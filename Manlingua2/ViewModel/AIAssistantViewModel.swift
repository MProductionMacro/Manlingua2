//
//  AIAssistantViewModel.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 12/11/24.
//

import Foundation
import AVFoundation
import Observation
import Speech

@Observable
class AIAssistantViewModel: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    var audioPlayer: AVAudioPlayer!
    var audioRecorder: AVAudioRecorder!
    var recordingSession = AVAudioSession.sharedInstance()
    
    var animationTimer: Timer?
    var recordingTimer: Timer?
    var audioPower = 0.0
    var prevAudioPower: Double?
    var processingSpeechTask: Task<Void, Never>?
    
   // var selectedVoice = VoiceType.alloy
    var captureURL: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first!.appendingPathComponent("recording.m4a")
    }
    
    var state = VoiceChatStatsenum.idle {
        didSet { print(state) }
    }
    var isIdle: Bool {
        if case .idle = state {
            return true
        }
        return false
    }
    
    var siriWaveFormOpacity: CGFloat {
        switch state {
        case .recordingSpeech, .playingSpeech: return 1
        default: return 0
        }
    }
    
    override init() {
        super.init()
        do {
            try recordingSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            
            try recordingSession.setActive(true)
            
            AVAudioApplication.requestRecordPermission { [unowned self] allowed in
                if !allowed {
                    self.state = .error("Recording not allowed by the user" as! Error)
                }
            }
        } catch {
            state = .error(error)
        }
    }
    
    
    
    func startCaptureAudio() {
        resetValues()
        state = .recordingSpeech
        do {
            audioRecorder = try AVAudioRecorder(url: captureURL,
                                                settings: [
                                                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                                                    AVSampleRateKey: 12000,
                                                    AVNumberOfChannelsKey: 1,
                                                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                                                ])
            audioRecorder.isMeteringEnabled = true
            audioRecorder.delegate = self
            audioRecorder.record()
            
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [unowned self]_ in
                guard self.audioRecorder != nil else { return }
                self.audioRecorder.updateMeters()
                let power = min(1, max(0, 1 - abs(Double(self.audioRecorder.averagePower(forChannel: 0)) / 50) ))
                self.audioPower = power
            })
            
            recordingTimer = Timer.scheduledTimer(withTimeInterval: 1.6, repeats: true, block: { [unowned self]_ in
                guard self.audioRecorder != nil else { return }
                self.audioRecorder.updateMeters()
                let power = min(1, max(0, 1 - abs(Double(self.audioRecorder.averagePower(forChannel: 0)) / 50) ))
                if self.prevAudioPower == nil {
                    self.prevAudioPower = power
                    return
                }
                if let prevAudioPower = self.prevAudioPower, prevAudioPower < 1 && power < 0.7 {
                    self.finishCaptureAudio()
                    return
                }
                self.prevAudioPower = power
            })
            
        } catch {
            resetValues()
            state = .error(error)
        }
    }
    
    func transcribeAudioInMandarin(completion: @escaping (String?) -> Void) {
         let mandarinLocale = Locale(identifier: "zh-CN")
         let recognizer = SFSpeechRecognizer(locale: mandarinLocale)
         let request = SFSpeechURLRecognitionRequest(url: captureURL)
         
         recognizer?.recognitionTask(with: request) { result, error in
             if let error = error {
                 print("Transcription error: \(error.localizedDescription)")
                 completion(nil)
             } else if let result = result {
                 // Transcribed text in Mandarin
                 let transcription = result.bestTranscription.formattedString
                 completion(transcription)
             }
         }
     }

     func finishCaptureAudio() {
         resetValues()
         do {
             let data = try Data(contentsOf: captureURL)
             print("TASK FINISHED")
             transcribeAudioInMandarin { transcription in
                 if let transcription = transcription {
                     print("Transcription Result: \(transcription)")
                 } else {
                     print("No transcription available")
                 }
             }
         } catch {
             state = .error(error)
             resetValues()
         }
     }


    
    func processSpeechTask(audioData: Data) -> Task<Void, Never> {
        Task { @MainActor [unowned self] in
            do {
                self.state = .processingSpeech
                
                
            } catch {
                if Task.isCancelled { return }
                state = .error(error)
                resetValues()
            }
        }
    }
    
    func playAudio(data: Data) throws {
        self.state = .playingSpeech
        audioPlayer = try AVAudioPlayer(data: data)
        audioPlayer.isMeteringEnabled = true
        audioPlayer.delegate = self
        audioPlayer.play()
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { [unowned self]_ in
            guard self.audioPlayer != nil else { return }
            self.audioPlayer.updateMeters()
            let power = min(1, max(0, 1 - abs(Double(self.audioPlayer.averagePower(forChannel: 0)) / 160) ))
            self.audioPower = power
        })
    }
    
    func cancelRecording() {
        resetValues()
        state = .idle
    }
    
    func cancelProcessingTask() {
        processingSpeechTask?.cancel()
        processingSpeechTask = nil
        resetValues()
        state = .idle
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            resetValues()
            state = .idle
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        resetValues()
        state = .idle
    }
    
    func resetValues() {
        audioPower = 0
        prevAudioPower = nil
        audioRecorder?.stop()
        audioRecorder = nil
        audioPlayer?.stop()
        audioPlayer = nil
        recordingTimer?.invalidate()
        recordingTimer = nil
        animationTimer?.invalidate()
        animationTimer = nil
    }

}

enum VoiceChatStatsenum{
    case idle
    case recordingSpeech
    case processingSpeech
    case playingSpeech
    case error(Error)
}

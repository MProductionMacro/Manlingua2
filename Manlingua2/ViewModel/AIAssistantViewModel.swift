//
//  AIAssistantViewModel.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 12/11/24.


import AVFoundation
import Foundation
import Observation
import XCAOpenAIClient
import Speech

@Observable
class AIAssistantViewModel: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    let client = //MARK: Khusus ini, replace sama OpenAIClient dari Notion
    var audioPlayer: AVAudioPlayer!
    var audioRecorder: AVAudioRecorder!
    var recordingSession = AVAudioSession.sharedInstance()
    var animationTimer: Timer?
    var recordingTimer: Timer?
    var audioPower = 0.0
    var prevAudioPower: Double?
    var processingSpeechTask: Task<Void, Never>?
    
    var selectedVoice = VoiceType.echo
    var lastTranscription: String?
    var textToSpeechViewModel = TextToSpeech.shared
    
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
                    self.state = .error("Recording not allowed by the user")
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
                if let prevAudioPower = self.prevAudioPower, prevAudioPower < 0.7 && power < 0.5 {
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
    
    func finishCaptureAudio() {
        resetValues()
        do {
            let data = try Data(contentsOf: captureURL)
//            transcribeAudioInMandarin { transcription in
//                guard let transcribedText = transcription else {
//                    print("Transcription failed.")
//                    self.state = .error(NSError(domain: "TranscriptionError", code: -1, userInfo: nil))
//                    return
//                }
//
//                // After transcription is complete, pass it to processSpeechTask
//                print("\(transcribedText)")
//                let lastTranscribe = transcribedText
                processingSpeechTask = self.processSpeechTask(audioString: data)
//            processingSpeechTask = self.processSpeechTask(audioString: "你知道什么是生意")
//            }
        } catch {
            state = .error(error)
            resetValues()
        }
    }
    
    
    func processSpeechTask(audioString: Data) -> Task<Void, Never> {
        Task { @MainActor [unowned self] in
            do {
                self.state = .processingSpeech
//                let prompt = try await client.generateAudioTransciptions(audioData: audioString)
//                print(prompt)
                
                let transcribedText = try await transcribeAudioInMandarin()
                self.lastTranscription = transcribedText
                print("Transcribed Text: \(self.lastTranscription)")


//                 //Menggunakan hasil transcription untuk menghasilkan prompt                try Task.checkCancellation()
                try Task.checkCancellation()
                let responseText = try await client.promptChatGPT(
                    prompt: self.lastTranscription!,
                    assistantPrompt: "Act as a Chinese business assistant, answer directlu and concisely"
                )
//
                try Task.checkCancellation()
                
//                let responseText = try await client.promptChatGPT(prompt: prompt, assistantPrompt: "You are a Helpful Chinese Business Assistant, answer it eficient and quick answer so the user easy to understand")
//                let responseText = try await client.promptChatGPT(prompt: audioString)
                
                print(responseText)
            
//                try Task.checkCancellation()
                let data = try await client.generateSpeechFrom(input: responseText, voice:
                        .init(rawValue: selectedVoice.rawValue) ?? .alloy)
                
                try Task.checkCancellation()
//                textToSpeechViewModel.configureAndSpeak(text: responseText, rate: 0.3)
                try self.playAudio(data: data)
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
    
    
    func transcribeAudioInMandarin() async throws -> String {
            let mandarinLocale = Locale(identifier: "zh-CN")
            guard let recognizer = SFSpeechRecognizer(locale: mandarinLocale) else {
                throw NSError(domain: "SFSpeechRecognizerError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Speech recognizer is not available."])
            }
            let request = SFSpeechURLRecognitionRequest(url: captureURL)
    
            return try await withCheckedThrowingContinuation { continuation in
                var hasResumed = false // Flag to ensure continuation is called only once
    
                recognizer.recognitionTask(with: request) { result, error in
                    guard !hasResumed else { return } // Prevent multiple resumptions
    
                    if let error = error {
                        hasResumed = true
                        continuation.resume(throwing: error)
                    } else if let result = result, result.isFinal { // Only capture the final result
                        hasResumed = true
                        continuation.resume(returning: result.bestTranscription.formattedString)
                    }
                }
            }
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

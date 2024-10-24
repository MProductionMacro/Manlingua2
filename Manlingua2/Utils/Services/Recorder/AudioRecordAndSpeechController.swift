//
//  NewAudioRecorder.swift
//  Manlingua2
//
//  Created by Paulus Michael on 22/10/24.
//

import AVFoundation
import Speech

class AudioRecordAndSpeechController: ObservableObject {
   var audioRecorder: AVAudioRecorder?
   var audioFileURL: URL?
   private let audioSession = AVAudioSession.sharedInstance()
   private let speechSynthesizer = AVSpeechSynthesizer()
   private var utterance: AVSpeechUtterance?
   
   func requestPermissions() {
      AVAudioSession.sharedInstance().requestRecordPermission { granted in
         if !granted {
            print("Microphone permission denied")
         }
      }
      
      SFSpeechRecognizer.requestAuthorization { authStatus in
         switch authStatus {
         case .authorized:
            print("Speech recognition permission granted")
         default:
            print("Speech recognition permission denied")
         }
      }
   }
   
   func prepareForRecording() {
      do {
         // Set the audio session category to play and record
         try audioSession.setCategory(.playAndRecord, mode: .spokenAudio, options: [.mixWithOthers, .defaultToSpeaker])
         
         try audioSession.setActive(true)
         
         audioFileURL = getAudioFileURL()
         
         let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
         ]
         
         audioRecorder = try AVAudioRecorder(url: audioFileURL!, settings: settings)
         audioRecorder?.prepareToRecord()
      } catch {
         print("Failed to prepare for recording: \(error.localizedDescription)")
      }
   }
   
   
   func startRecording() {
      audioRecorder?.record()
      //      print("Recording started")
   }
   
   func stopRecording() {
      audioRecorder?.stop()
      //      print("Recording stopped")
   }
   
   func transcribeAudio(completion: @escaping (String) -> Void) {
      guard let audioURL = audioFileURL else {
         completion("No audio to transcribe")
         return
      }
      
      let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
      
      let request = SFSpeechURLRecognitionRequest(url: audioURL)
      
      recognizer?.recognitionTask(with: request) { result, error in
         if let error = error {
            print("Transcription error: \(error.localizedDescription)")
            completion("Transcription error: \(error.localizedDescription)")
         } else if let result = result {
            completion(result.bestTranscription.formattedString)
         }
      }
   }
   
   func setUtterance(text: String) {
      utterance = AVSpeechUtterance(string: text)
      utterance?.voice = AVSpeechSynthesisVoice(language: "zh-CN")
      utterance?.rate = AVSpeechUtteranceDefaultSpeechRate
      utterance?.volume = 1.0
   }
   
   func speak(text: String) {
      guard let utterance = utterance else { return }
      speechSynthesizer.speak(utterance)
   }
   
   
   private func getAudioFileURL() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      let filePath = paths[0].appendingPathComponent("recording.m4a")
      return filePath
   }
   
   func deactivateSession(){
      do {
         try audioSession.setActive(false)
      } catch {
         print("Failed to deactivate session: \(error.localizedDescription).")
      }
   }
}


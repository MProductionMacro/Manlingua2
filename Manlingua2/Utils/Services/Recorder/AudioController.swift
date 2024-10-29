//
//  AudioRecordingManager.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 11/10/24.
//

import Foundation
import AVFoundation

protocol AudioControllerDelegate: AnyObject {
   func audioControllerDidStopPlaying()
}

//ngatur lagi di state mana sekarang
enum AudioControllerState {
   case stopped
   case playing
   case recording
}

//controllernya
class AudioController: NSObject {
   
   private var audioRecorder : AVAudioRecorder! //buat ngerecord
   private var audioFileName : URL? //file name
   private(set) var state = AudioControllerState.stopped // inisialisasi statenya
   private var player: AVAudioPlayer! // buat ngeplay suaranya
   weak var delegate: AudioControllerDelegate?
   
   override init() {
      super.init()
      setupAudioSession()
   }
   
   private func setupAudioSession() {
      let session = AVAudioSession.sharedInstance()
      do {
         if !session.isOtherAudioPlaying {
            try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
         } else {
            print("Audio session already active.")
         }
      } catch {
         fatalError("Failed to configure and activate session: \(error.localizedDescription).")
      }
   }
   
   private func setUpRecorder() {
      let tempDir = URL(fileURLWithPath: NSTemporaryDirectory())
      let fileURL = tempDir.appendingPathComponent("recording.wav")
      
      print("File path for recording: \(fileURL.path)") // Log the file path to check if it’s valid
      
      let settings: [String: Any] = [
         AVFormatIDKey: Int(kAudioFormatLinearPCM),
         AVSampleRateKey: 44_100.0,
         AVNumberOfChannelsKey: 1,
         AVLinearPCMBitDepthKey: 16,
         AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
      ]
      
      do {
         audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
         audioRecorder.delegate = self
         audioRecorder.prepareToRecord()
      } catch {
         print("Error initializing audio recorder: \(error.localizedDescription)")
         audioRecorder = nil // Explicitly set to nil if initialization fails
      }
   }
   
   @discardableResult
   func startRecording() -> Bool {
      setUpRecorder()
      guard let audioRecorder = audioRecorder else {
         print("Audio Recorder is not set up.")
         return false
      }
      let started = audioRecorder.record()
      state = .recording
      return started
   }
   
   func stopRecording() {
      audioRecorder.stop()
      state = .stopped
      deactivateAudioSession()
   }
   
   private func deactivateAudioSession() {
      do {
         try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
      } catch {
         print("Failed to deactivate session: \(error.localizedDescription).")
      }
   }
   
   func playRecording() {
      guard let url = audioFileName else {
         print("No recording to play")
         return
      }
      
      resetAudioComponents() // Reset before playing again
      
      do {
         player = try AVAudioPlayer(contentsOf: url)
         player?.delegate = self
         player?.play()
         state = .playing
      } catch {
         print("Error playing recording: \(error.localizedDescription)")
      }
   }
   
   func playSoundFromData(speak: String) {
      guard let folderURL = Bundle.main.url(forResource: speak, withExtension: "m4a") else {
         print("Sound file not found.")
         return
      }
      do {
         player = try AVAudioPlayer(contentsOf: folderURL)
         player?.delegate = self
         player?.prepareToPlay()
         player?.play()
         print("Playing sound.")
      } catch let error {
         print("Error initializing audio player: \(error.localizedDescription)")
      }
   }
   
   func getAudioFileName() -> URL?{
      return audioFileName
   }
   
   func requestPermission(completion: @escaping (Bool) -> Void){
      AVAudioApplication.requestRecordPermission {  granted in
         DispatchQueue.main.async {
            if granted {
               completion(true)
               print("Permission granted.")
               //                    print("Permission granted.")
               //                    self?.startRecording()
               
            }else{
               completion(false)
               //                    print("Permission denied.")
            }
         }
      }
   }
   
   func resetAudioComponents() {
      if audioRecorder != nil && audioRecorder.isRecording {
         audioRecorder.stop()
         audioRecorder = nil
      }
      if player != nil && player.isPlaying {
         player.stop()
         player = nil
      }
   }
   
}


extension AudioController: AVAudioRecorderDelegate {
   // The AVAudioRecorderDelegate method.
   func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
      
      guard flag else {
         print("Recording was not successful.")
         return
      }
      let destURL = FileManager.default.urlInDocumentsDirectory(named: "recording.wav")
      
      do {
         try FileManager.default.removeItem(at: destURL)
      } catch {
         print("Could not remove existing file: \(error.localizedDescription)")
      }
      do {
         try FileManager.default.copyItem(at: recorder.url, to: destURL)
         audioFileName = destURL
      } catch {
         print("Error copying recording: \(error.localizedDescription)")
      }
      //        try? FileManager.default.copyItem(at: recorder.url, to: destURL)
      //        recorder.prepareToRecord()
      //
      //        audioFileName = destURL
   }
}

extension AudioController: AVAudioPlayerDelegate {
   func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      delegate?.audioControllerDidStopPlaying()
      state = .stopped
      deactivateAudioSession()
   }
}

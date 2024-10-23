//
//  NewAudioRecorder.swift
//  Manlingua2
//
//  Created by Paulus Michael on 22/10/24.
//

import SwiftUI
import AVFoundation

class AudioManager: NSObject, ObservableObject {
   var audioRecorder: AVAudioRecorder?
   var audioPlayer: AVAudioPlayer?
   @Published var isRecording = false
   @Published var isPlaying = false
   
   let audioFilename: URL
   
   override init() {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      audioFilename = paths[0].appendingPathComponent("audioRecording.m4a")
   }
   
   func startRecording() {
      let settings = [
         AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
         AVSampleRateKey: 12000,
         AVNumberOfChannelsKey: 1,
         AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
      ]
      
      do {
         audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
         audioRecorder?.prepareToRecord()
         audioRecorder?.record()
         isRecording = true
      } catch {
         print("Failed to start recording: \(error.localizedDescription)")
      }
   }
   
   func stopRecording() {
      audioRecorder?.stop()
      isRecording = false
   }
   
   func playAudio() {
      do {
         audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
         audioPlayer?.play()
         isPlaying = true
         audioPlayer?.delegate = self
      } catch {
         print("Failed to play audio: \(error.localizedDescription)")
      }
   }
   
   func stopPlaying() {
      audioPlayer?.stop()
      isPlaying = false
   }
}

extension AudioManager: AVAudioPlayerDelegate {
   func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      isPlaying = false
   }
}


//
//  AudioRecorderViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 22/10/24.
//

import AVFoundation

class AudioRecorderViewModel: NSObject, ObservableObject, AudioControllerDelegate {
    private let audioController = AudioController()
    
    @Published var isRecording = false
    @Published var isPlaying = false
    @Published var hasRecording = false
    
    override init() {
        super.init()
        audioController.delegate = self
    }
    
    func requestPermissionAndRecord() {
        if isRecording {
            stopRecording()
        } else {
            audioController.requestPermission { granted in
                if granted {
                    self.startRecording()
                } else {
                    print("Recording permission denied.")
                }
            }
        }
    }
    
    private func startRecording() {
        if audioController.startRecording() {
            isRecording = true
        } else {
            print("Failed to start recording.")
        }
    }
    
    private func stopRecording() {
        audioController.stopRecording()
        isRecording = false
        hasRecording = true
    }
    
    func playRecording() {
        guard !isRecording else {
            print("Cannot play while recording.")
            return
        }
        audioController.playRecording()
        isPlaying = true
    }
    
    // Delegate method
    func audioControllerDidStopPlaying() {
        isPlaying = false
    }
}

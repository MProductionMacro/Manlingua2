//
//  TextToSpeech.swift
//  Manlingua2
//
//  Created by Paulus Michael on 04/10/24.
//

import AVFoundation

class TextToSpeech: TextToSpeechProtocol {
    private let synthesizer = AVSpeechSynthesizer()
    
    // General method to configure and speak text
    private func configureAndSpeak(text: String, rate: Float) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.rate = rate
        utterance.pitchMultiplier = 1.0
        utterance.volume = 0.8
        
        synthesizer.speak(utterance)
        
        print("Speaking: \(text)")
        
        // Wait for speech to complete
        while synthesizer.isSpeaking {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        }
        
        print("Finished speaking")
    }
    
    // Public method to speak text at normal speed
    func speak(text: String) {
        configureAndSpeak(text: text, rate: 0.5)
    }
    
    // Public method to speak text at a slower speed
    func speakSlow(text: String) {
        configureAndSpeak(text: text, rate: 0.25) // Adjusted rate for slower speech
    }
}

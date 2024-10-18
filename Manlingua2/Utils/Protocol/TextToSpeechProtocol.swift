//
//  TextToSpeechProtocol.swift
//  Manlingua2
//
//  Created by Paulus Michael on 04/10/24.
//

import Foundation

protocol TextToSpeechProtocol {
    func speak(text: String)
    func speakSlow(text: String)
}

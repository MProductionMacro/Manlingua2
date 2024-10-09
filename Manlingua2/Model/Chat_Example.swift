//
//  Chat_Example.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import Foundation

enum Speaking_Example: String, Codable {
    case repeating
    case translate
}

struct Chat_Example: Codable, Identifiable {
    let id: Int
    let speaker: String
    let pinyin: String
    let hanzi: String
    let meaning: String
    let speaking: Speaking_Example?  // Properti opsional
    let choice: [String]?    // Properti opsional
    let answer: String?
    
}

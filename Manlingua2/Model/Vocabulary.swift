//
//  Vocabulary.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 16/10/24.
//

import Foundation

struct Vocabulary: Identifiable, Codable, Hashable {
    let id = UUID()
    let hanzi: String
    let pinyin: String
    let meaning: String
    
    enum CodingKeys: String, CodingKey {
        case hanzi
        case pinyin
        case meaning
    }
}

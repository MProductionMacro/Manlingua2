//
//  Vocabulary.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 16/10/24.
//

import Foundation
import SwiftData

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

@Model
class VocabularyModel{
    var id = UUID()
    var hanzi: String
    var pinyin: String
    var meaning: String
    init(vocab: Vocabulary){
        self.hanzi = vocab.hanzi
        self.pinyin = vocab.pinyin
        self.meaning = vocab.meaning
    }
}


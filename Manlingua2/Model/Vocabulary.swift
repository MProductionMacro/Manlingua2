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
    let hanziSentence: String
    let pinyinSentence: String
    let meaningSentence: String
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case hanzi
        case pinyin
        case meaning
        case hanziSentence
        case pinyinSentence
        case meaningSentence
        case language
    }
}

@Model
class VocabularyModel{
    var id = UUID()
    var hanzi: String
    var pinyin: String
    var meaning: String
    var hanziSentence: String
    var pinyinSentence: String
    var meaningSentence: String
    var language: String
    
    init(vocab: Vocabulary){
        self.hanzi = vocab.hanzi
        self.pinyin = vocab.pinyin
        self.meaning = vocab.meaning
        self.hanziSentence = vocab.hanziSentence
        self.pinyinSentence = vocab.pinyinSentence
        self.meaningSentence = vocab.meaningSentence
        self.language = vocab.language
    }
}

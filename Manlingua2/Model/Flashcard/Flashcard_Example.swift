//
//  Flashcard.swift
//  TE_JSON_Real
//
//  Created by Arrick Russell Adinoto on 29/09/24.
//

//struct Flashcard_Example hasn't been finalize yet.
struct Flashcard_Example: Codable, Identifiable, Hashable {
    var id: Int
    var hanzi: String
    var pinyin: String
    var meaning: String
    var image_url: String
    var voice_url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hanzi
        case pinyin
        case meaning
        case image_url
        case voice_url
    }
}


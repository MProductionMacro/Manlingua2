//
//  Flashcard.swift
//  TE_JSON_Real
//
//  Created by Arrick Russell Adinoto on 29/09/24.
//

struct Flashcard: Codable, Identifiable, Hashable {
    public var id: Int
    public var hanzi: String
    public var pinyin: String
    public var meaning: String
    public var image_url: String
    public var voice_url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hanzi
        case pinyin
        case meaning
        case image_url
        case voice_url
    }
}

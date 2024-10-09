//
//  Quiz.swift
//  TE_JSON_Real
//
//  Created by Arrick Russell Adinoto on 30/09/24.
//

import Foundation

struct Story_Example: Codable, Identifiable {
    let id: Int
    let number: Int
    let title: String
    let hanzi: String
    let description: String
    let pinyin: String
    let subChapter: [SubChapter_Example]
}

struct SubChapter_Example: Codable, Identifiable {
    let id: Int
    let title: String
    let pinyin: String
    let hanzi: String
    let duration: Int
}



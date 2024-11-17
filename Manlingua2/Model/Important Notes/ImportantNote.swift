//
//  ImportantNote.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import Foundation
import SwiftData

struct ImportantNote: Hashable, Decodable{
    let title: String
    let allowed: String
    let forbidden: String
    let caution: String
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case allowed
        case forbidden
        case caution
        case language
    }
}

@Model
class ImportantNoteModel{
    var id = UUID()
    var title: String
    var allowed: String
    var forbidden: String
    var caution: String
    var language: String

    init(from importantNote: ImportantNote){
        self.title = importantNote.title
        self.allowed = importantNote.allowed
        self.forbidden = importantNote.forbidden
        self.caution = importantNote.caution
        self.language = importantNote.language
    }
}

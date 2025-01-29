//
//  ImportantNote.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import Foundation
import SwiftData

struct ImportantNote: Hashable, Decodable{
    public let title: String
    public let allowed: String
    public let forbidden: String
    public let caution: String
    public let language: String
    
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
    public var id = UUID()
    public var title: String
    public var allowed: String
    public var forbidden: String
    public var caution: String
    public var language: String

    init(from importantNote: ImportantNote){
        self.title = importantNote.title
        self.allowed = importantNote.allowed
        self.forbidden = importantNote.forbidden
        self.caution = importantNote.caution
        self.language = importantNote.language
    }
}

//
//  ImportantNote.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import Foundation
import SwiftData

struct ImportantNote: Hashable{
    let title: String
    let allowed: String
    let forbidden: String
    let caution: String

}

@Model
class ImportantNoteModel{
    var id = UUID()
    var title: String
    var allowed: String
    var forbidden: String
    var caution: String

    init(_ importantNote: ImportantNote){
        self.title = importantNote.title
        self.allowed = importantNote.allowed
        self.forbidden = importantNote.forbidden
        self.caution = importantNote.caution
    }
}

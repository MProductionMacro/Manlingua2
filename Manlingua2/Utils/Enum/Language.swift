//
//  Language.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/11/24.
//
/*
enum Language{
    case english
    case indonesian
}
*/
enum Lang: String, Codable{
    case english = "en"
    case indonesian = "id"
}

import SwiftData

@Model
class Language{
    var lang: Lang
    init(lang: Lang){
        self.lang = lang
    }
}


//
//  DonePageModel.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 16/10/24.
//

import Foundation


enum DonePageString: String, CaseIterable{
   case story
   case flashCard
    
    var page : String{
        switch self {
        case .story : return "Cerita"
        case .flashCard : return "Flashcard"
        }
    }
}


enum PartOfTheStory: CaseIterable{
    case first
    case second
    case third
    // add more
    
    var titleOfDescription: String{
        switch self {
        case .first : return "Bagian 1 - Perkenalan Nama"
        case .second : return "Bagian 2 - Perkenalan Umur"
        case .third : return "Bagian 3 - Perkenalan Pekerjaan"
        }
    }
}

struct DonePageModel{
    static let title = "Selamat!"
    static let description = "Kamu telah menyelesaikan"
    static let returnToStoryTxt = "Balik ke cerita"
    static let bookSymbol = "books.vertical"
    static let returnSymbol = "return"
    
    static let imageName = "congratulationImage"
    
    static let buttonWidth : CGFloat = 361
    static let buttonHeight : CGFloat = 64
}

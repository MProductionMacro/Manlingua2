//
//  DonePageDisplayMode.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 04/11/24.
//

import SwiftUI

enum DonePageDisplayMode: Equatable, Hashable {
    case flashcard
    case story(id: Int, judul: String)
}

//Nanti code yang dibawah ini, semuanya akan dihapus
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
   static let houseSymbol = "house"
   static let returnSymbol = "arrow.uturn.forward"
   
   static let imageName = "congratulationImage"
   
   static let buttonWidth : CGFloat = 361
   static let buttonHeight : CGFloat = 64
}

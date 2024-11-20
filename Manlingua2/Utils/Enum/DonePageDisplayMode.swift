//
//  DonePageDisplayMode.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 04/11/24.
//

import SwiftUI

enum DonePageDisplayMode: Equatable, Hashable {
   case flashcard
   case story(storyId: Int, subChapterId: Int)
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
   static let returnToStoryTxt = "Beranda"
   static let houseSymbol = "house"
   static let returnSymbol = "arrow.uturn.forward"
   
   static let imageName = "congratulationImage"
   
   static let buttonWidth : CGFloat = 361
   static let buttonHeight : CGFloat = 64
}

struct DonePageTitle {
   static func title(storyId: Int, subChapterId: Int) -> String {
      switch (storyId, subChapterId) {
      case (1, 1):
         return "Perkenalan Nama"
      case (1, 2):
         return "Obrolan Ringan"
      case (1, 3):
         return "Minum Teh"
         // Add more cases as needed
         
         
      case (2, 1):
         return "Tanya Kebutuhan"
      case (2, 2):
         return "Spesifikasi Barang"
      case (2, 3):
         return "Negosiasi Harga"
         // Add more cases as needed
         
      case (3, 1):
         return "Pembahasan Kontrak"
      case (3, 2):
         return "Pengiriman"
      case (3, 3):
         return "Jadwal Pengiriman"
         // Add more cases as needed
         
      case (4, 1):
         return "Pembayaran"
      case (4, 2):
         return "Penerimaan Barang"
      case (4, 3):
         return "Penyelesaian Akhir"
         // Add more cases as needed
         
      default:
         return "Unknown Title"
      }
   }
}



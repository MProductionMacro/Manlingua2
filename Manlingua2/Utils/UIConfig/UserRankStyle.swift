//
//  UserRankStyle.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 20/11/24.
//

import Foundation
import SwiftUI

struct UserRankStyle{
   public static func getTextColor(_ userRank : UserRank) -> Color{
      switch(userRank){
      case .Berlian:
         return Color.berlian
      case .Platina :
         return Color.platina
      case .Emas :
         return Color.emas
      case .Perak :
         return Color.perak
      case .Perunggu:
         return Color.perunggu
      }
   }
   
   public static func getBackgroundColor(_ userRank : UserRank) -> Color{
      switch(userRank){
      case .Berlian :
         return Color.berlianBackground
      case .Platina :
         return Color.platinaBackground
      case .Emas :
         return Color.emasBackground
      case .Perak :
         return Color.perakBackground
      case .Perunggu:
         return Color.perugguBackground
      }
      
   }
}

enum UserRank: String, Hashable, Codable, CaseIterable {
   case Perunggu
   case Perak
   case Emas
   case Platina
   case Berlian
}

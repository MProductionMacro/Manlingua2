//
//  UserRankStyle.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 20/11/24.
//

import Foundation
import SwiftUI

struct UserRankStyle{
    static func getTextColor(_ userRank : String) -> Color{
        switch(userRank){
        case "Berlian" :
            return Color.berlian
        case "Platina" :
            return Color.platina
        case "Emas" :
            return Color.emas
        case "Perak" :
            return Color.perak
        default :
            return Color.perunggu
        }
    }
    
    static func getBackgroundColor(_ userRank : String) -> Color{
        switch(userRank){
        case "Berlian" :
            return Color.berlianBackground
        case "Platina" :
            return Color.platinaBackground
        case "Emas" :
            return Color.emasBackground
        case "Perak" :
            return Color.perak
        default :
            return Color.perunggu
        }
    }
    
}

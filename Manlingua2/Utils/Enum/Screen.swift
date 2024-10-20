//
//  Screen.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import Foundation
import SwiftUI

enum Screen: Hashable {
    case splashScreen
    case mainScreen
    case pinyinInisial
    case pinyinFinal
    case pinyinNada
    case journeyPage(storyId: Int)
    case storyPage
    case dictionary(judul:String, storyId: Int, showFavoriteVocab: Bool)
    case donePage
    case flashcardPage
}

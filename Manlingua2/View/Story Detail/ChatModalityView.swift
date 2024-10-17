//
//  ChatModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 17/10/24.
//

import SwiftUI

struct ChatModalityView: View {
   var chat: Chat_Example
   @Binding var modalAppeared: Bool
   @Binding var currentIndex: Int
   
   var body: some View {
      Correct(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning, modalAppeared: $modalAppeared, currentIndex: $currentIndex)
   }
}

//#Preview {
//   ChatModalityView()
//}

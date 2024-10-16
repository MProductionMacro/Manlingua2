//
//  BubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/10/24.
//

import SwiftUI

struct BubbleChatView: View {
   @Binding var chat: Chat_Example
   var type: ChatType
   
   var body: some View {
      //      GeometryReader { geometry in
      HStack(spacing: 0) {
         switch type {
         case .speaker1:
            Speaker1BubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin)
               .padding(.leading)
            
         case .speaker2:
            Speaker2BubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin)
               .padding(.trailing)
            
         case .question:
            QuestionBubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin)
               .padding(.trailing)
         }
      }
      //      }
   }
}

//#Preview {
//   BubbleChatView(pinyin: .constant("Pinyin"), hanzi: .constant("Hanzi"), type: .question)
//      .background(Color.black.opacity(0.5))
//}

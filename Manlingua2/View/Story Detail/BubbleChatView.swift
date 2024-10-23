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
      HStack(spacing: 0) {
         switch type {
         case .speaker1:
            Speaker1BubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning)
               .padding(.leading)
            
         case .speaker2:
            Speaker2BubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning)
               .padding(.trailing)
            
         case .question:
            QuestionBubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin, question: chat.question ?? "")
               .padding(.trailing)
         }
      }
//      .padding(.vertical, 4)
   }
}

//#Preview {
//   BubbleChatView(pinyin: .constant("Pinyin"), hanzi: .constant("Hanzi"), type: .question)
//      .background(Color.black.opacity(0.5))
//}

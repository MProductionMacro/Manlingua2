//
//  BubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/10/24.
//

import SwiftUI

struct BubbleChatView: View {
   @Binding var chat: Chat
   var type: ChatType
   var questionIndex: Int
   var isActive: Bool
   
   var actionAfterTap: () -> Void
   
   var body: some View {
      HStack(spacing: 0) {
         switch type {
         case .speaker1:
            Speaker1BubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning, actionAfterTap: actionAfterTap)
               .padding(.leading, UIScreen.main.bounds.width * 0.05)
            
         case .speaker2:
            Speaker2BubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning, actionAfterTap: actionAfterTap)
               .padding(.trailing, UIScreen.main.bounds.width * 0.05)
            
         case .question:
            QuestionBubbleChatView(hanzi: chat.hanzi, pinyin: chat.pinyin, question: chat.question ?? "", meaning: chat.meaning, isActive: isActive, actionAfterTap: actionAfterTap)
               .padding(.trailing, UIScreen.main.bounds.width * 0.05)
         }
      }
//      .padding(.vertical, 4)
   }
}

//#Preview {
//   BubbleChatView(pinyin: .constant("Pinyin"), hanzi: .constant("Hanzi"), type: .question)
//      .background(Color.black.opacity(0.5))
//}

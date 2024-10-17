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
   
   @State var hasAnswered: Bool = false
   
   var body: some View {
      ZStack{
         if hasAnswered {
            Correct(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning, modalAppeared: $modalAppeared, currentIndex: $currentIndex, hasAnswered: $hasAnswered)
               .transition(.move(edge: .bottom))
         }else {
            if let choices = chat.choice {
               QuestionModalityView(choices: choices) {
                  withAnimation{
                     hasAnswered = true
                  }
               }
               .transition(.move(edge: .bottom))
            }else{
               MicrophoneModalityView(actionOnPressed: {
                  withAnimation{
                     hasAnswered = true
                  }
               })
               .transition(.move(edge: .bottom))
            }
         }
      }
      .animation(.easeInOut, value: hasAnswered)
   }
}

//#Preview {
//   ChatModalityView()
//}

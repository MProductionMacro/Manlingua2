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
   @State var isCorrect: Bool = false
   @State var selectedAnswer: String? = nil
   
   var body: some View {
      ZStack{
         if hasAnswered {
            if isCorrect {
               Correct(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning, modalAppeared: $modalAppeared, currentIndex: $currentIndex, hasAnswered: $hasAnswered)
                  .transition(.move(edge: .bottom))
            }else{
               Wrong(hanzi: chat.hanzi, pinyin: chat.pinyin, meaning: chat.meaning, modalAppeared: $modalAppeared, currentIndex: $currentIndex, hasAnswered: $hasAnswered)
                  .transition(.move(edge: .bottom))
            }
         }else {
            if let choices = chat.choice {
               QuestionModalityView(choices: choices) { answer in
                  selectedAnswer = answer
                  withAnimation {
                     isCorrect = (answer == chat.answer)
                     hasAnswered = true
                  }
               }
               .transition(.move(edge: .bottom))
            }else{
               MicrophoneModalityView() { answer in
                  withAnimation{
//                     isCorrect = (answer == chat.answer)
                     isCorrect = true
                     hasAnswered = true
                  }
               }
               .transition(.move(edge: .bottom))
            }
         }
      }
      .animation(.easeInOut, value: hasAnswered)
      .onAppear {
         modalAppeared = true
      }
   }
}

//#Preview {
//   ChatModalityView()
//}

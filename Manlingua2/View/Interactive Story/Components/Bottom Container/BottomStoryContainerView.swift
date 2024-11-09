//
//  BottomAudioButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 07/11/24.
//

import SwiftUI

struct BottomStoryContainerView: View {
   @Binding var currentIndex: Int
   @Binding var questionAppeared: Bool
   
   var storyId: Int
   var chatType: ChatType
   var choices: [String]?
   var onAnswerSelected: (String) -> Void
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var storyViewModel: StoryViewModel
   
   @State var textToSpeech = TextToSpeech()
   @State private var temporarilyPressedButton: String? = nil
   
   @State var tapping = false
   
   var body: some View {
      VStack(spacing: 0) {
         BottomStoryButtons(currentIndex: $currentIndex, storyId: storyId)
         
         if chatType == .question {
            Divider()
            
            VStack{
               if questionAppeared {
                  if let choices = choices {
                     QuestionModalityView(choices: choices) { answer in
                        withAnimation{
                           questionAppeared = false
                        }
                        
                        currentIndex += 1
                        //                  selectedAnswer = answer
                        //                  withAnimation {
                        //                     isCorrect = (answer == chat.answer)
                        //                     hasAnswered = true
                        //                  }
                     }
                     .padding(.vertical, 24)
                     .transition(.move(edge: .bottom))
                  }else{
                     MicrophoneModalityView() { answer in
                        withAnimation{
                           questionAppeared = false
                        }
                        
                        currentIndex += 1
                        //                  withAnimation{
                        //                     isCorrect = (answer == chat.answer)
                        //                     hasAnswered = true
                        //                  }
                     }
                     .padding(.vertical, 24)
                     .transition(.move(edge: .bottom))
                  }
               }
            }
            .onAppear {
               withAnimation{
                  questionAppeared = true
               }
            }
         }
      }
      .frame(maxWidth: .infinity)
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
      .animation(.easeInOut(duration: 0.3), value: chatType == .question)
   }
   
   private func handleButtonPress(_ button: String) {
      // Set the button as temporarily pressed
      temporarilyPressedButton = button
      
      // After 0.2 seconds, reset the pressed button state
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
         temporarilyPressedButton = nil
      }
   }
}

#Preview {
   BottomStoryContainerView(currentIndex: .constant(1), questionAppeared: .constant(true), storyId: 1, chatType: .question, choices: [], onAnswerSelected: {result in})
      .frame(maxHeight: .infinity)
      .background(.black)
      .environmentObject(Router())
      .environmentObject(HomeViewModel())
      .environmentObject(StoryViewModel())
}

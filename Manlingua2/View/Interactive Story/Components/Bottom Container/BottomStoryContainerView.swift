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
   @Binding var selectedAnswer: String?
   @Binding var isCorrect: Bool
   @Binding var hasAnswered: Bool
   @Binding var isSpeakingQuestion: Bool
   
   var storyId: Int
   var chatType: ChatType
   var choices: [String]?
   var realAnswer: String?
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var storyViewModel: StoryViewModel
   
   @State var textToSpeech = TextToSpeech()
   @State var isSpeaking = false
   
   var body: some View {
      VStack(spacing: 0) {
         BottomContainerButtons(bookAction: {
            router.push(.dictionary(judul: homeViewModel.stories_example[storyId].title, displayMode: .story(id: storyId)))
         }, speakerAction: {
            isSpeaking = true
            textToSpeech.speak(text: storyViewModel.chat_example[currentIndex].hanzi)
         }, turtleAction: {
            textToSpeech.speakSlow(text: storyViewModel.chat_example[currentIndex].hanzi)
         }, isSpeaking: $isSpeaking)
         
         if chatType == .question {
            Divider()
            
            VStack{
               if questionAppeared {
                  if let choices = choices {
                     QuestionModalityView(choices: choices) { answer in
                        selectedAnswer = answer
                        
                        withAnimation {
                           isSpeakingQuestion = false
                           isCorrect = (answer == realAnswer)
                           hasAnswered = true
                        }
                     }
                     .padding(.vertical, 24)
                     .transition(.move(edge: .bottom))
                  }else{
                     MicrophoneModalityView() { answer in
                        withAnimation{
                           isSpeakingQuestion = true
                           isCorrect = (answer == realAnswer)
                           hasAnswered = true
                        }
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
      .background(.cardBackground)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
      .animation(.easeInOut(duration: 0.3), value: chatType == .question)
   }
}

//#Preview {
//   BottomStoryContainerView(currentIndex: .constant(1), questionAppeared: .constant(true), storyId: 1, chatType: .question, choices: [], onAnswerSelected: {result in})
//      .frame(maxHeight: .infinity)
//      .background(.black)
//      .environmentObject(Router())
//      .environmentObject(HomeViewModel())
//      .environmentObject(StoryViewModel())
//}

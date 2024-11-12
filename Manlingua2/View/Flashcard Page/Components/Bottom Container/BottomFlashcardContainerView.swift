//
//  BottomFlashcardContainerView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 10/11/24.
//

import SwiftUI

struct BottomFlashcardContainerView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var flashcardViewModel: FlashcardViewModel
   
   @State var textToSpeech = TextToSpeech()
   
   var body: some View {
      VStack(spacing: 0){
         BottomContainerButtons {
            router.push(.dictionary(judul: "Kata Favorit", displayMode: .favorite))
         } speakerAction: {
            textToSpeech.speak(text: flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
         } turtleAction: {
            textToSpeech.speakSlow(text: flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
         }
         
         Divider()
         
         MicrophoneModalityView { answer in
            
         }
         .padding(.vertical, 24)
      }
      .frame(maxWidth: .infinity)
      .background(.cardBackground)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   BottomFlashcardContainerView()
      .frame(maxHeight: .infinity)
      .background(.black)
      .environmentObject(Router())
      .environmentObject(FlashcardViewModel())
      .environment(\.colorScheme, .dark)
}


/*
import SwiftUI

struct BottomFlashcardContainerView: View {
   @Binding var isCorrect: Bool
   @Binding var hasAnswered: Bool
   
   var storyId: Int
   var realAnswer: String?
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var storyViewModel: StoryViewModel
   
   @State var textToSpeech = TextToSpeech()
   
   var body: some View {
      VStack(spacing: 0) {
         BottomContainerButtons {
            router.push(.dictionary(judul: homeViewModel.stories_example[storyId].title, displayMode: .story(id: storyId)))
         } speakerAction: {
            textToSpeech.speak(text: storyViewModel.chat_example[currentIndex].hanzi)
         } turtleAction: {
            textToSpeech.speakSlow(text: storyViewModel.chat_example[currentIndex].hanzi)
         }
         
         if chatType == .question {
            Divider()
            
            VStack{
               if questionAppeared {
                  if let choices = choices {
                     QuestionModalityView(choices: choices) { answer in
                        selectedAnswer = answer
                        
                        withAnimation {
                           isCorrect = (answer == realAnswer)
                           hasAnswered = true
                        }
                     }
                     .padding(.vertical, 24)
                     .transition(.move(edge: .bottom))
                  }else{
                     MicrophoneModalityView() { answer in
                        withAnimation{
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
*/

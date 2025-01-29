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
   
   @State private var textToSpeech = TextToSpeech()
   @State private var isSpeaking = false
   @State private var transcribedAnswer = ""
   //@State private var answer = ""
    
   var body: some View {
      VStack(spacing: 0) {
         BottomContainerButtons(bookAction: {
            router.push(.dictionary(judul: homeViewModel.stories_example[storyId].title, displayMode: .story(id: storyId)))
         }, speakerAction: {
            isSpeaking = true
            textToSpeech.speak(text: storyViewModel.chats[currentIndex].hanzi)
         }, turtleAction: {
            textToSpeech.speakSlow(text: storyViewModel.chats[currentIndex].hanzi)
         }, isSpeaking: $isSpeaking)
         
         if chatType == .question {
            Divider()
            
            VStack{
               if questionAppeared {
                  if let choices = choices {
                     QuestionModalityView(choices: choices) { answer in
                        selectedAnswer = answer
                        //self.answer = answer
                        withAnimation {
                           isSpeakingQuestion = false
                           //isCorrect = (answer == realAnswer)
                           isCorrectCheck()
                           hasAnswered = true
                        }
                     }
                     .padding(.vertical, 24)
                     .transition(.move(edge: .bottom))
                  }else{
                     MicrophoneModalityView() { answer in
                        withAnimation{
                           isSpeakingQuestion = true
                           self.transcribedAnswer = answer
                            
                            print(transcribedAnswer)
                            print(realAnswer)
                            isCorrect = (transcribedAnswer == realAnswer)
                            //isCorrectCheck()
                            print(isCorrect)
                           //let transcribedAnswer = answer
                           //                           DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                           withAnimation {
                               //print(transcribedAnswer)
                               //print(realAnswer)
                               isCorrectCheck()
                              //isCorrect = (transcribedAnswer == realAnswer)
                              //isCorrectCheck()
                           }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                withAnimation{
                                    hasAnswered = true
                                }
                            }
                           //                           }
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
    
    private func isCorrectCheck(){
        if let choices = choices{
            
            print(selectedAnswer)
            print(realAnswer)
            
            isCorrect = (selectedAnswer == realAnswer)
            print(isCorrect)
        }
        else{
            print(transcribedAnswer)
            print(realAnswer)
            //if let transcribedAnswer
            isCorrect = (transcribedAnswer == realAnswer)
            
            print(isCorrect)
        }
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

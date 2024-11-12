//
//  BottomContainer.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/10/24.
//

import SwiftUI

struct BottomContainerView : View {
   @EnvironmentObject var router: Router
   @ObservedObject var viewModel: FlashcardViewModel
   @Binding var audioController: AudioController
   
   var body : some View {
      if viewModel.showMicrophone{
         //         FlashcardMicrophoneModalityView(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, responseText: $viewModel.apiResult, showMicrophone: $viewModel.showMicrophone, audioController: $audioController)
         /*
          MicrophoneModalityView { result in
          viewModel.apiResult = result
          }
          */
         UserAnswerView(viewModel: viewModel)
            .onTapGesture{
               withAnimation {
                  viewModel.showMicrophone = false
               }
            }
            .animation(.easeInOut, value: viewModel.showMicrophone)
         
         
      }else if viewModel.checkResult() {
         FlashcardCorrect(showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
            viewModel.performSwipeRight()
         }
         .transition(.move(edge: .bottom))
         //.animation(.easeInOut, value: viewModel.showMicrophone)
         
      }
      else{
         FlashcardWrong(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
            viewModel.performSwipeRight()
         }
         .transition(.move(edge: .bottom))
         //.animation(.easeInOut, value: viewModel.showMicrophone)
         
      }
      
   }
}


#Preview {
   BottomContainerView(
      viewModel: FlashcardViewModel(),
      audioController: .constant(AudioController())
   )
}

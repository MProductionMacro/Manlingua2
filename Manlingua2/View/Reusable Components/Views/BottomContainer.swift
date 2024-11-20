//
//  BottomContainer.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/10/24.
//
/*
import SwiftUI

struct BottomContainerView : View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: FlashcardViewModel
   
   @StateObject var audioController = AudioController.shared
   
   var body : some View {
      if viewModel.showMicrophone{
         //         FlashcardMicrophoneModalityView(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, responseText: $viewModel.apiResult, showMicrophone: $viewModel.showMicrophone, audioController: $audioController)
         /*
          MicrophoneModalityView { result in
          viewModel.apiResult = result
          }
          */
         UserAnswerView()
            .animation(.easeInOut, value: viewModel.showMicrophone)
      }else if viewModel.checkResult() {
         FlashcardCorrect(showMicrophone: $viewModel.showMicrophone){
            viewModel.performSwipeRight()
         }
         .transition(.move(edge: .bottom))
         //.animation(.easeInOut, value: viewModel.showMicrophone)
         
      }
      else{
         FlashcardWrong(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, showMicrophone: $viewModel.showMicrophone){
            viewModel.performSwipeRight()
         }
         .transition(.move(edge: .bottom))
         //.animation(.easeInOut, value: viewModel.showMicrophone)
         
      }
      
   }
}


#Preview {
   BottomContainerView()
      .environmentObject(FlashcardViewModel())
}
*/

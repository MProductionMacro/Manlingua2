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
         FlashcardMicrophoneModalityView(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, responseText: $viewModel.apiResult, showMicrophone: $viewModel.showMicrophone, audioController: $audioController)
         
      }
      else if viewModel.checkResult() {
         FlashcardCorrect(showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
            viewModel.performSwipeRight()
         }
      }
      else{
         FlashcardWrong(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
            viewModel.performSwipeRight()
         }
      }
   }
}


#Preview {
   BottomContainerView(
      viewModel: FlashcardViewModel(),
      audioController: .constant(AudioController())
   )
}

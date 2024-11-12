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
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   BottomFlashcardContainerView()
      .frame(maxHeight: .infinity)
      .background(.black)
      .environmentObject(Router())
      .environmentObject(FlashcardViewModel())
}

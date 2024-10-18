//
//  MicrophoneModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI 

struct FlashcardMicrophoneModalityView: View {
   @Binding var responseText : String
    @Binding var showMicrophone: Bool
   var onPressedMic: () -> Void
   
   var body: some View {
      VStack(spacing: 32){
          /*
         ZStack {
            RoundedRectangle(cornerRadius: 16)
               .fill(.gold2)
               .frame(height: UIScreen.main.bounds.height * 0.08)
            
            Text(responseText)
         }
           */
          FlashcardAudioBTN(message: $responseText, showMicrophone: $showMicrophone)
              .padding(.vertical, 10)
              //.padding(.bottom, 10)
      }
      .frame(width: 368, height: 180)
      .padding()
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}
/*
#Preview {
   MicrophoneModalityView(onPressedMic: {})
      .frame(maxHeight: .infinity)
      .background(.black)
}
*/


//
//  MicrophoneModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct FlashcardMicrophoneModalityView: View {
   var hanzi: String
   @Binding var responseText : String
   @Binding var showMicrophone: Bool
   @Binding var audioController: AudioController
//   var onPressedMic: () -> Void
   
   var body: some View {
      VStack(spacing: 32){
         
         ZStack {
            RoundedRectangle(cornerRadius: 16)
               .fill(.gold2)
               .frame(height: UIScreen.main.bounds.height * 0.08)
            
            Text("Ucapkan \(hanzi)")
         }
         FlashcardAudioBTN(message: $responseText, showMicrophone: $showMicrophone, audioController: $audioController)
            .padding(.top, -15)
         //.padding(.vertical, 10)
         //.padding(.bottom, 10)
      }
      .frame(width: 368, height: 180)
      .padding()
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   FlashcardMicrophoneModalityView(
      hanzi: "Halo",
      responseText: .constant("Hello World"), // default binding value
      showMicrophone: .constant(false),      // default binding value
      audioController: .constant(AudioController())
   )
   .frame(maxHeight: .infinity)
   .background(.black)
}

/*
 #Preview {
 MicrophoneModalityView(onPressedMic: {})
 .frame(maxHeight: .infinity)
 .background(.black)
 }
 */


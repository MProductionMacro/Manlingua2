//
//  MicrophoneModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct MicrophoneModalityView: View {
   @State var responseText : String = ""
   
   var onPressedMic: () -> Void
   
   var body: some View {
      VStack(spacing: 32){
         ZStack {
            RoundedRectangle(cornerRadius: 16)
               .fill(.gold2)
               .frame(height: UIScreen.main.bounds.height * 0.08)
            
            Text(responseText)
         }
         
         AudioBTN(responseText: $responseText, actionOnPressed: onPressedMic)
      }
      .frame(maxWidth: .infinity)
      .padding()
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   MicrophoneModalityView(onPressedMic: {})
      .frame(maxHeight: .infinity)
      .background(.black)
}

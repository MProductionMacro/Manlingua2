//
//  MicrophoneModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct MicrophoneModalityView: View {
   @State var responseText : String = ""
   
   var onPressedMic: (String) -> Void
   
   var body: some View {
      VStack(spacing: 32){
         Text(responseText)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.08)
            .background(.gold2)
            .clipShape(.rect(cornerRadius: 16))
         
         AudioBTN(responseText: $responseText, actionOnPressed: onPressedMic)
      }
      .frame(maxWidth: .infinity)
      .padding()
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}

//#Preview {
//   MicrophoneModalityView(onPressedMic: {})
//      .frame(maxHeight: .infinity)
//      .background(.black)
//}

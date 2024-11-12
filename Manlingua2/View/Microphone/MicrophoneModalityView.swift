//
//  MicrophoneModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct MicrophoneModalityView: View {
   @State var responseText : String = ""
   @State var showMicrophone = false
   
   var onPressedMic: (String) -> Void
   
   var body: some View {
      VStack(spacing: 32){
         Text(responseText)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.08)
            .foregroundStyle(.black)
            .background(.gold2)
            .clipShape(.rect(cornerRadius: 16))
         
         AudioBTN(message: $responseText, showMicrophone: $showMicrophone) { result in
            responseText = result
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
               onPressedMic(result)
            }
         }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .background(.cardBackground)
   }
}

#Preview {
   MicrophoneModalityView(onPressedMic: {result in})
      .frame(maxHeight: .infinity)
      //.background(.black)
      .environment(\.colorScheme, .dark)
}

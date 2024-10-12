//
//  SoundButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 03/10/24.
//

import SwiftUI

struct SoundButtonView: View {
   let vocab: String
   let tts = TextToSpeech()
   
   var body: some View {
      Button(action: {
         tts.speak(text: vocab)
      }) {
         Circle()
            .fill(Color.orange3)
            .overlay(
               Image(systemName: "speaker.wave.2.fill")
                  .foregroundStyle(.white)
                  .font(.caption)
            )
      }
   }
}

#Preview {
   SoundButtonView(vocab: "")
}

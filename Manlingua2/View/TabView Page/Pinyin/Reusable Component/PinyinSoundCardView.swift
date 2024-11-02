//
//  PinyinSoundCardView2.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//

import SwiftUI
import AVFoundation


struct PinyinSoundCardView: View {
   var text: String
   var speak: String
   @Binding var audioController: AudioController
   
   var body: some View {
      VStack(spacing: 4) {
         Text(text)
            .font(.system(size: 24))
            .foregroundStyle(.black)
         
         Button {
            audioController.playSoundFromData(speak: speak)
         } label: {
            Image(systemName: "speaker.wave.2")
               .font(.system(size: 12))
         }
         .buttonStyle(CircleButton())
      }
//      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
//      .padding(.horizontal)
      .frame(maxWidth: .infinity)
      .background(Color.white)
      .overlay(
         RoundedRectangle(cornerRadius: 12)
            .stroke(Color.customLightGray, lineWidth: 1)
      )
   }
}

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
      VStack(spacing: 10) {
         Text(text)
            .font(.system(size: 18))
            .foregroundStyle(.black)
         
         
         BubbleSoundButton(
            icon: "sound",
            buttonAction: {
               audioController.playSoundFromData(speak: speak)
            },
            size: 25,
            soundSize: 12
         )
         
         
      }
      //TODO: Size hard coded
      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
      .background(Color.white)
      .overlay(
         RoundedRectangle(cornerRadius: 12)
            .stroke(Color.customLightGray, lineWidth: 1)
      )
   }
}

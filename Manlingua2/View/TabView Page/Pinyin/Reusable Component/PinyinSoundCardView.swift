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
   
   @EnvironmentObject var audioController: AudioRecordAndSpeechController
   
   var body: some View {
      VStack(spacing: 4) {
         Text(text)
            .font(.system(size: 18))
            .foregroundStyle(.black)
         
         Button {
            audioController.playSoundFromData(speak: speak)
         } label: {
            Image(.sound)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: UIScreen.main.bounds.width * 0.035, height: UIScreen.main.bounds.width * 0.035)
         }
         .buttonStyle(SoundBubbleButton())
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

#Preview{
   PinyinSoundCardView(text:"e", speak:"e")
      .environmentObject(AudioRecordAndSpeechController())
}

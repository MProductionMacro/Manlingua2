//
//  PinyinSoundCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 01/10/24.
//

import SwiftUI

struct PinyinSoundCardView: View {
   var text: String
   var speak: String
   
   var body: some View {
      VStack(spacing: 10) {
         Text(text)
            .font(.system(size: 18))
            .foregroundStyle(.black)
         
         BubbleSoundButton(
            icon: "sound",
            buttonAction: { },
            size: 25,
            soundSize: 12
         )
      }
      //TODO: Size hard coded
      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
      .background(Color.white)
//      .cornerRadius(20)
      .overlay(
         RoundedRectangle(cornerRadius: 12)
            .stroke(Color.customLighterGray, lineWidth: 2)
      )
      .padding(.horizontal, 4)
   }
}

#Preview {
   PinyinSoundCardView(text: "b", speak: "b")
}

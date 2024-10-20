//
//  BubbleSoundButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 01/10/24.
//

import SwiftUI

struct BubbleSoundButton: View {
   var icon: String
   var buttonAction: () -> Void
   var size: CGFloat
   var soundSize: CGFloat
   
   var body: some View {
      Button(action: {
         buttonAction()
      }) {
         ZStack {
            Rectangle()
               .fill(Color.orange3)
               .frame(width: size, height: size)
               .cornerRadius(16)
            Image(icon)
               .resizable()
               .foregroundColor(.white)
               .frame(width: soundSize, height: soundSize)
         }
      }
   }
}

#Preview {
   BubbleSoundButton(
      icon: "sound", buttonAction: {
      }, size: 48, soundSize: 20
   )
}

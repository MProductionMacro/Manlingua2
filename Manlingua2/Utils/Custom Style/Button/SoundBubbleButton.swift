//
//  SoundBubbleButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/10/24.
//

import SwiftUI

struct SoundBubbleButton: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding(10)
         .foregroundColor(.white)
         .background(.orange3)
         .clipShape(Circle())
   }
}

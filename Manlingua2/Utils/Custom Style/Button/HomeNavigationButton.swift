//
//  HomeNavigationButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 10/11/24.
//

import SwiftUI

struct HomeNavigationButton: ButtonStyle {
   var image: String
   var text: String
   
   func makeBody(configuration: Configuration) -> some View {
      VStack(alignment: .center, spacing: 0) {
         Image(systemName: image)
            .font(.judulBiasa())
            .fontWeight(.regular)
            .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.width * 0.07, alignment: .center)
            .foregroundStyle(.orange3)
            .padding()
         
         Text(text)
            .font(.pinyin())
            .fontWeight(.bold)
            .frame(width: UIScreen.main.bounds.width * 0.14)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .foregroundStyle(.white)
            .background(.orange3)
      }
      .background(configuration.isPressed ? Color.orange3.opacity(0.35) : Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
      .scaleEffect(configuration.isPressed ? 1.1 : 1.0) // Immediate scale change on press
      .animation(configuration.isPressed ? .none : .easeOut, value: configuration.isPressed) // Animate on release only
   }
}

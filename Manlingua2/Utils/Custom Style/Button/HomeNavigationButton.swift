//
//  HomeNavigationButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 10/11/24.
//

import SwiftUI

struct HomeNavigationButton: PrimitiveButtonStyle {
   var image: String
   var text: String
   
   @State var pressed = false
   @State private var holdAction = false
   
   func makeBody(configuration: Configuration) -> some View {
      VStack(alignment: .center, spacing: 0) {
         Image(systemName: image)
            .font(.judulBiasa())
            .fontWeight(.regular)
            .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.width * 0.075, alignment: .center)
            .foregroundStyle(.orangeDarkMode)
            .padding()
         
         Text(text)
            .font(Font.system(size: 10, weight: .regular))
            .fontWeight(.bold)
            .frame(width: UIScreen.main.bounds.width * 0.15)//0.14
            .padding(.vertical, 8) //.padding(.horizontal)
            .padding(.horizontal)
            .foregroundStyle(.white)
            .background(.orangeDarkMode)
      }
      .background(pressed ? Color.orangeDarkMode.opacity(0.35) : Color.cardBackground)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(color: .cardShadow.opacity(0.18), radius: 8, x: 0, y: 0)
      .scaleEffect(pressed ? 1.1 : 1.0) // Immediate scale change on press
      .animation(pressed ? .none : .easeOut, value: pressed) // Animate on release only
      .gesture(
         DragGesture(minimumDistance: 0)
            .onChanged { _ in
               pressed = true
            }
            .onEnded { value in
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
                  if abs(value.translation.width) < 10 && abs(value.translation.height) < 10 {
                     // Trigger action only if the user hasn't moved significantly
                     withAnimation {
                        configuration.trigger()
                     }
                  }
                  pressed = false
               }
            }
      )
   }
}

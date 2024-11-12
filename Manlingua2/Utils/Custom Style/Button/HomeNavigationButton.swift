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
      .background(pressed ? Color.orange3.opacity(0.35) : Color.white)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
      .scaleEffect(pressed ? 1.1 : 1.0) // Immediate scale change on press
      .animation(pressed ? .none : .easeOut, value: pressed) // Animate on release only
      .gesture(DragGesture(minimumDistance: 0).onChanged { _ in
         pressed = true
      }.onEnded { value in
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
            withAnimation {
               pressed = false
               // optionally, use value.location and a geometry reader to determine whether
               // the gesture ended inside the button's label
               //               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               //                  configuration.trigger()
               //               }
               configuration.trigger()
            }
         }
      })
   }
}

//
//  CustomOnTapButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 08/11/24.
//

import SwiftUI

struct CustomOnTapButton : PrimitiveButtonStyle {
   @State var pressed = false
   
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding(.vertical, 24)
         .fontWeight(pressed ? .bold : .regular)
         .animation(.easeInOut, value: pressed)
         .background(pressed ? .orange3.opacity(0.35) : .clear)
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
//         .onTapGesture {
//            pressed = true
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
//               withAnimation {
//                  pressed = false
//               }
//            }
//         }
   }
}

//
//  ButtonsList.swift
//  Manlingua2
//
//  Created by Paulus Michael on 07/10/24.
//

import SwiftUI

//TODO: Viewnya dipisah aja

struct PreviousButton: View {
   var action: () -> Void
   var body: some View {
      Button(action: action, label: {
         Label("Previous", image: "previousIcon")
            .modifier(ButtonTextModifier())
         
      })
      .modifier(ButtonModifier())
   }
}

struct NextButton: View {
   var action: () -> Void
   var body: some View {
      Button(action: action, label: {
         Label("Next", image: "nextIcon")
            .modifier(ButtonTextModifier())
         
      })
      .labelStyle(TrailingIconLabelStyle())
      .modifier(ButtonModifier())
   }
}

struct TrailingIconLabelStyle: LabelStyle {
   func makeBody(configuration: Configuration) -> some View {
      HStack {
         configuration.title
         configuration.icon
      }
   }
}

struct ButtonTextModifier: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.callout)
         .fontWeight(.medium)
         .foregroundStyle(Color(.orange3))
   }
}

struct ButtonModifier: ViewModifier {
   func body(content: Content) -> some View {
      content
         .padding(.horizontal, 16)
         .padding(.vertical, 12)
         .background(Color(.gold2))
         .clipShape(RoundedRectangle(cornerRadius: 16))
   }
}

#Preview {
   VStack {
      PreviousButton(action: {
         print("Previous button tapped")
      })
      
      NextButton(action: {
         print("Next button tapped")
      })
   }
}

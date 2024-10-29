//
//  SecondaryButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 25/10/24.
//

import SwiftUI

struct SecondaryButton: ButtonStyle {
   var isDisabled: Bool
   
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .foregroundStyle(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3)
         .font(.button())
         .padding()
         .background(.white)
         .clipShape(.rect(cornerRadius: 16))
         .overlay(
            RoundedRectangle(cornerRadius: 16)
               .stroke(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3, lineWidth: 2)
         )
   }
}

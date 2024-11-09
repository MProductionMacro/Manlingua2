//
//  PrimaryButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 25/10/24.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
   var isDisabled: Bool
   
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
//         .frame(maxWidth: .infinity)
         .padding(.horizontal)
         .padding(.vertical, 12)
         .foregroundStyle(isDisabled ? Color(red: 0.7, green: 0.7, blue: 0.7) : Color.white)
         .font(.button())
         .background(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3)
         .clipShape(.rect(cornerRadius: 8))
   }
}

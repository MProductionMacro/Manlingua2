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
         .foregroundStyle(Color.white)
         .font(.button())
         .background(isDisabled ? Color.homeCardLock : Color.orangeDarkMode)
         .clipShape(.rect(cornerRadius: 8))
   }
}


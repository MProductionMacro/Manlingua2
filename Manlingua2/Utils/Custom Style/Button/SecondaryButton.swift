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
         .foregroundStyle(isDisabled ? Color.homeCardLock : Color.orangeDarkMode)
         .font(.button())
         .padding(12)
         .background(.cardBackground)
         .clipShape(.rect(cornerRadius: 8))
         .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isDisabled ? Color.homeCardLock : Color.orangeDarkMode, lineWidth: 2)
         )
   }
}


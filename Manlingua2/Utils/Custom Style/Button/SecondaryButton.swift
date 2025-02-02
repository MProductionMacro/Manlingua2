import SwiftUI

struct SecondaryButton: ButtonStyle {
   var isDisabled: Bool
   
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .foregroundStyle(isDisabled ? Color.homeCardLock : Color.orangeDarkMode)
         .font(.button())
         .padding(12)
         .background(.blankBackground)
         .clipShape(.rect(cornerRadius: 8))
         .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isDisabled ? Color.homeCardLock : Color.orangeDarkMode, lineWidth: 2)
         )
   }
}


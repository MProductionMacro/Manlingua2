import SwiftUI

struct CircleButton: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding(10)
         .foregroundColor(.white)
         .background(.orangeDarkMode)
         .clipShape(Circle())
   }
}

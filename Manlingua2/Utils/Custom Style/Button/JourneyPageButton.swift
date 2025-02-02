import SwiftUI

struct JourneyPageButton: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding()
         .foregroundColor(.orange)
         .background(.gold2)
         .clipShape(.rect(cornerRadius: 12))
   }
}

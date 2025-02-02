import SwiftUI

struct CompletedButton: PrimitiveButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
  //         .frame(maxWidth: .infinity)
           .padding(.horizontal)
           .padding(.vertical, 12)
           .foregroundStyle(Color.white)
           .font(.button())
           .background(.green1)
           .clipShape(.rect(cornerRadius: 8))
           .disabled(true)
    }
}

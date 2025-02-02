import SwiftUI

struct PrimaryButton: PrimitiveButtonStyle{
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
           .gesture(DragGesture(minimumDistance: 0).onChanged { _ in
           }.onEnded { value in
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
                 withAnimation {
                    configuration.trigger()
                 }
              }
           })
    }
}

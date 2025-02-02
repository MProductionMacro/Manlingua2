import SwiftUI

struct ChevronRightButton: PrimitiveButtonStyle{

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.button())
            .foregroundStyle(.orangeDarkMode)
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

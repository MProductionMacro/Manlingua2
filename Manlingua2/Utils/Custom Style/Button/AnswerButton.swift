import SwiftUI

struct AnswerButton: PrimitiveButtonStyle {
   @State var pressed = false
   
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding()
         .background(pressed ? .white.opacity(0.3) : .clear)
         .foregroundStyle(.black)
         .clipShape(.rect(cornerRadius: 12))
         .overlay {
            RoundedRectangle(cornerRadius: 12)
               .stroke(.orange1, lineWidth: 1)
         }
         .gesture(
            DragGesture(minimumDistance: 0)
               .onChanged { _ in
                  pressed = true
               }
               .onEnded { value in
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
                     if abs(value.translation.width) < 10 && abs(value.translation.height) < 10 {
                        // Trigger action only if the user hasn't moved significantly
                        withAnimation {
                           configuration.trigger()
                        }
                     }
                     pressed = false
                  }
               }
         )
//         .frame(maxWidth: .infinity)
   }
}

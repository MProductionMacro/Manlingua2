import SwiftUI

struct BottomContainerButtons: View {
   var bookAction: () -> Void
   var speakerAction: () -> Void
   var turtleAction: () -> Void
   
   @State private var isSpeakerPressed = false
   @Binding var isSpeaking: Bool
   
   var body: some View {
      HStack{
         Button {
            bookAction()
         } label: {
            Image(systemName: "book")
               .font(.titleKe2())
               .foregroundStyle(.orangeDarkMode)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
         
         Button {
            speakerAction()
         } label: {
            Image(systemName: "speaker.wave.2")
               .font(.titleKe2())
               .foregroundStyle(.orangeDarkMode)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
         
         Button {
            turtleAction()
         } label: {
            Image(systemName: "tortoise")
               .font(.titleKe2())
               .foregroundStyle(.orangeDarkMode)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
      }
      //.padding(.top, 8)
      //.padding(.bottom)
      .background(.cardBackground)
   }
}

#Preview {
   BottomContainerButtons(bookAction: {}, speakerAction: {}, turtleAction: {}, isSpeaking: .constant(false)).environment(\.colorScheme, .dark)
}


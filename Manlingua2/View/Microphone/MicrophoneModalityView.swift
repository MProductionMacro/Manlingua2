import SwiftUI

struct MicrophoneModalityView: View {
   @State private var responseText : String = ""
   @State private var showMicrophone = false
   
   var onPressedMic: (String) -> Void
   
   var body: some View {
      VStack(spacing: 32){
         AudioBTN(message: $responseText, showMicrophone: $showMicrophone) { result in
            responseText = result
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
               onPressedMic(result)
            }
         }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .background(.cardBackground)
   }
}

#Preview {
   MicrophoneModalityView(onPressedMic: {result in})
      .frame(maxHeight: .infinity)
      //.background(.black)
      .environment(\.colorScheme, .dark)
}

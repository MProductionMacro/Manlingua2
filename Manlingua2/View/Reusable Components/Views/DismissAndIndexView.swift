import SwiftUI

struct DismissAndIndexView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var storyVM: StoryViewModel
   @EnvironmentObject var flashcardVM: FlashcardViewModel
   
   @Binding var showConfirmationAlert: Bool
   @Binding var currentIndex: Int
   
   var chatCounts: Int
   
   var body: some View {
      HStack(spacing: 4) {
         Button {
            showConfirmationAlert = true
         } label: {
            Image(systemName: "xmark")
               .font(.judulBiasa())
            //                     .frame(width: 32, height: 32)
               .foregroundStyle(.orangeDarkMode)
         }.reusableAlert(
            isPresented: $showConfirmationAlert,
            alertData: AlertData(
               type: .confirmation,
               primaryAction: {
                  showConfirmationAlert = false
               },
               dismissAction: {
                  storyVM.currentIndex = 0
                  flashcardVM.currentIndex = 0
                  router.popToRoot()
               }
            )
         )
         
         Spacer()
         
         ProgressView(value: Double(currentIndex + 1) / Double(chatCounts))
            .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .greenNormalActive, unfilledColor: .progressBar))
      }
      .padding(.leading, UIScreen.main.bounds.width * 0.05)
      .padding(.trailing, UIScreen.main.bounds.width * 0.1)
      .padding(.top)
   }
}

//#Preview {
//   DismissAndIndexView()
//}

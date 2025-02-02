import SwiftUI

struct KataKataView: View {
   @EnvironmentObject private var router: Router
   
   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         Text("Kata-kata".localized)
            .font(.judulBiasa())
         
         HStack(spacing: 24) {
            Button {
                router.push(.loadingPage(screen: .flashcardPage))
            } label: {
               EmptyView()
            }
            .buttonStyle(HomeNavigationButton(image: "book.pages", text: "Flashcard"))
            
            Button {
                router.push(.loadingPage(screen:.dictionary(judul: "Kata Favorit".localized, displayMode: .favorite(isFromHome: true))))
            } label: {
               EmptyView()
            }
            .buttonStyle(HomeNavigationButton(image: "heart", text: "Favorit".localized))
            
            Button {
                router.push(.loadingPage(screen:.importantNote(displayMode: .favorite)))
            } label: {
               EmptyView()
            }
            .buttonStyle(HomeNavigationButton(image: "list.clipboard", text: "Catatan".localized))
         }
         .padding(.vertical)
         
      }
      .padding(.leading, 24)
      .frame(maxWidth: .infinity, alignment: .leading)
      //      .padding(.bottom)
   }
}

#Preview {
   KataKataView()
}


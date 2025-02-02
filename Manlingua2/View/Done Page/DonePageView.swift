import SwiftUI

struct DonePageView: View {
   @EnvironmentObject var flashcardVM: FlashcardViewModel
   @EnvironmentObject var storyVM: StoryViewModel
   @EnvironmentObject var router: Router
   
   var displayMode: DonePageDisplayMode
   var chapterId: Int
   var subChapterId: Int
   
   var body: some View {
      ZStack{
          Color.blankBackground.edgesIgnoringSafeArea(.all)
         VStack(spacing: 10){
             Text("Selamat!".localized)
               .font(.system(size: 40))
               .fontWeight(.bold)
               .padding(12)
            
             Text("Kamu telah menyelesaikan".localized)
               .font(Font.judulBiasa())
               .foregroundColor(.darkGrey)
            
            if case .story(let storyId, let subChapterId) = displayMode {
                Text("Bagian".localized + " \(subChapterId) - \(DonePageTitle.title(storyId: storyId, subChapterId: subChapterId).localized)".localized)
                  .font(Font.judulBiasa())
                  .foregroundColor(.darkGrey)
                  .padding(.bottom, 60)
            }
            else{
                Text("Flashcard Harian".localized)
                  .font(Font.judulBiasa())
                  .foregroundColor(.darkGrey)
                  .padding(.bottom, 60)
            }
            
            Image(DonePageModel.imageName)
               .frame(width: 335, height: 225)
               .padding(.bottom, 50)
            
            HStack(spacing: 24) {
               Button (action: {
                  flashcardVM.showDonePage = false
                  flashcardVM.currentIndex = 0
                  flashcardVM.currentIndexProgressBar  = 0
                  storyVM.currentIndex = 0
                  flashcardVM.reshuffleCards()
                  router.pop()
               }){
                  HStack(alignment: .center) {
                     Image(systemName: DonePageModel.returnSymbol)
                        .font(.button())
                        .frame(height: UIScreen.main.bounds.height * 0.01)
                     
                      Text("Ulang".localized)
                        .font(.button())
                  }
                  .frame(maxWidth: .infinity)
                  .padding(UIScreen.main.bounds.width * 0.03)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
               
               Button (action: {
                  flashcardVM.showDonePage = false
                  flashcardVM.currentIndex = 0
                  storyVM.currentIndex = 0
                  flashcardVM.reshuffleCards()
                  
                  switch displayMode {
                  case .flashcard:
                      router.push(.dictionary(judul: "Kata - kata favorit".localized, displayMode: .favorite(isFromHome: false)))
                  case .story(let storyId, let subChapterId):
                     router.push(.importantNote(displayMode: .subChapter(storyId: storyId, subChapterId: subChapterId)))
                  }
               }){
                  HStack {
                     Image(systemName: displayMode == .flashcard ? "bookmark" : "list.clipboard")
                        .font(.button())
                        .frame(height: UIScreen.main.bounds.height * 0.01)
                     
                      Text(displayMode == .flashcard ? "Favorit".localized : "Catatan".localized)
                        .font(.button())
                  }
                  .frame(maxWidth: .infinity)
                  .padding(UIScreen.main.bounds.width * 0.03)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
            }
            .padding(.horizontal)
            
            Button (action: {
                /*
               if displayMode != .flashcard {
                  storyVM.updateUserProgress(currentStory: chapterId, currentSubChapter: subChapterId)
               }
               */
               router.popToRoot()
            }){
               HStack {
                  Image(systemName: DonePageModel.houseSymbol)
                     .font(.button())
                  
                  Text("Belajar".localized)
                     .font(.button())
               }
               .foregroundStyle(Color.white)
               .frame(maxWidth: .infinity)
               .padding(UIScreen.main.bounds.width * 0.03)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
            .buttonStyle(PrimaryButton(isDisabled: false))
         }
      }
   }
}

#Preview {
   DonePageView(displayMode: .story(storyId: 1, subChapterId: 1), chapterId: 1, subChapterId: 1)
   
}

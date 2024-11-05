

import SwiftUI

struct FlashcardPageView: View {
   @EnvironmentObject var router: Router
   @StateObject var viewModel = FlashcardViewModel()
   @StateObject var singleton = CoreDataSingleton.shared
   @State var tutorialOverlay: Int = 1
   @State var audioController = AudioController.shared
   
   var body: some View {
      ZStack {
         VStack {
            HStack(spacing: 4) {
               Button {
                  router.pop()
               } label: {
                  Image(systemName: "rectangle.portrait.and.arrow.right")
                     .resizable()
                     .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07)
                     .foregroundStyle(.orange3)
               }
               
               Spacer()
               
               ProgressView(value: viewModel.getProgress())
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
            }
            .padding(.horizontal)
            
            Spacer()
            
            ZStack{
               ForEach(0 ..< viewModel.showVocabularies.count, id: \.self) { index in
                  if index >= viewModel.currentIndex {
                     viewModel.createFlashcardView(for: index)
                        .zIndex(Double(viewModel.showVocabularies.count - index))
                  }
               }
            }
            
            Spacer()
            
            BottomContainerView(viewModel: viewModel, audioController: $audioController)
         }
         .ignoresSafeArea(.container, edges: .bottom)
         .overlay{
            if singleton.hasNotOpenFlashcardPage(){
               FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
            }
         }
         
         FlashcardSidebarButton(viewModel: viewModel){
            tutorialOverlay = tutorialOverlay + 1
         }
         .offset(y: 160)
         
      }
      .frame(maxHeight: .infinity)
      .background(
         Image(.chatBackground)
            .scaledToFill()
      )
      .overlay{
         if viewModel.showDonePage {
            DonePageView(currentPage: .flashCard, currentPart: .first)
               .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
               .background(.white)
         }
      }
   }
}

#Preview {
   FlashcardPageView()
      .environmentObject(Router())
}



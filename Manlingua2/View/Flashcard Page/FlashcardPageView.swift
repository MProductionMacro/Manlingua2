//
//  LanguageSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct FlashcardPageView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: FlashcardViewModel
   @StateObject var singleton = UserDefaultSingleton.shared
   @State var tutorialOverlay: Int = 1
   @State var audioController = AudioController.shared
   @State var hasAnswered = false
   @State var isCorrect = false
   @State private var showConfirmationAlert = false
   
   var body: some View {
      ZStack (alignment: .bottom){
         VStack {
            DismissAndIndexView(showConfirmationAlert: $showConfirmationAlert, currentIndex: $viewModel.currentIndex, chatCounts: viewModel.showVocabularies.count)
            
            Spacer()
            
            HStack(alignment: .top){
               ZStack(alignment: .top){
                  ForEach(0 ..< viewModel.showVocabularies.count, id: \.self) { index in
                     if index >= viewModel.currentIndex {
                        viewModel.createFlashcardView(for: index)
                           .zIndex(Double(viewModel.showVocabularies.count - index))
                           .opacity(viewModel.currentIndex == index ? 1 : 0)
                     }
                  }
               }
               .shadow(radius: 0, x: 0, y: 0)
            }
            .shadow(color: .cardShadow.opacity(0.2), radius: 12, x: 0, y: 0)
            
            Spacer()
            
            if hasAnswered {
               CorrectOrWrong(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, pinyin: viewModel.showVocabularies[viewModel.currentIndex].pinyin, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, isCorrect: isCorrect) {
                  withAnimation{
                     DispatchQueue.main.async {
                        viewModel.performSwipeRight()
                        hasAnswered = false
                        if viewModel.currentIndex == viewModel.showVocabularies.count - 1 {
                           router.push(.donePage(displayMode: .flashcard, chapterId: 0, subChapterId: 0))
                        }
                     }
                  }
               } tryAgainFunc: {
                  withAnimation{
                     DispatchQueue.main.async {
                        hasAnswered = false
                     }
                  }
               }
               .transition(.move(edge: .bottom))
            }
            else{
               BottomFlashcardContainerView(isCorrect: $isCorrect, hasAnswered: $hasAnswered)
                  .transition(.move(edge: .bottom))
            }
         }
         .frame(maxHeight: .infinity)
         
         //          BottomContainerView(viewModel: viewModel, audioController: $audioController).onTapGesture{
         //              router.push(.donePage(currentPage: .story, currentPart: .first))
         //          }
         
         /*
          .overlay{
          if singleton.hasNotOpenFlashcardPage(){
          FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
          }
          }
          
          FlashcardSidebarButton(viewModel: viewModel){
          tutorialOverlay = tutorialOverlay + 1
          }
          .offset(y: 160)
          */
      }
      .frame(maxHeight: .infinity)
      .background(
         Image(.chatBackground)
            .scaledToFill()
      )
      .ignoresSafeArea(.container, edges: .bottom)
      .onAppear{
         viewModel.currentIndex = 0
         viewModel.reshuffleCards()
      }
   }
}

#Preview {
   FlashcardPageView()
      .environmentObject(Router())
      .environmentObject(FlashcardViewModel())
}



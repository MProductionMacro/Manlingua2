//
//  FlashcardPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct FlashcardPageView: View {
   @EnvironmentObject var router: Router
   //@EnvironmentObject var viewModel: FlashcardViewModel
   @EnvironmentObject var viewModel: FlashcardViewModel
   @StateObject var singleton = UserDefaultSingleton.shared
   @State var tutorialOverlay: Int = 1
   @State var audioController = AudioController.shared
   @State var hasAnswered = false
   @State var isCorrect = false
   @State private var showConfirmationAlert = false
   @State var answer:String = ""
    @State var isTransitioning: Bool = false
   var body: some View {
      ZStack (alignment: .bottom){
         VStack {
            DismissAndIndexView(showConfirmationAlert: $showConfirmationAlert, currentIndex: $viewModel.currentIndexProgressBar, chatCounts: viewModel.showVocabularies.count)
            
            Spacer()
            
            HStack(alignment: .top){
               ZStack(alignment: .top){
                  ForEach(0 ..< viewModel.showVocabularies.count, id: \.self) { index in
                     if index >= viewModel.currentIndex {
                        viewModel.createFlashcardView(for: index)
                           .zIndex(Double(viewModel.showVocabularies.count - index))
                           .opacity(viewModel.currentIndex == index ? 1 : 0)
                           .onDisappear(){
                               print("MASUKK")
                           }
                     }
                  }
               }
               .shadow(radius: 0, x: 0, y: 0)
            }
            .shadow(color: .cardShadow.opacity(0.2), radius: 12, x: 0, y: 0)
            .onAppear{
                print("All Vocabularies 1 : ")
                for vocab in viewModel.showVocabularies{
                    print(vocab.pinyin)
                }
            }
            
            Spacer()
            
            if hasAnswered {
                FlashcardCorrectOrWrong(answer: $answer, hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, pinyin: viewModel.showVocabularies[viewModel.currentIndex].pinyin, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, isCorrect: $isCorrect) {
                  withAnimation{
                      /*
                      guard !isTransitioning else { return }
                      isTransitioning = true
                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                         isTransitioning = false
                      }
                      */
                      
                      DispatchQueue.main.async {
                          //withAnimation{
                              viewModel.performSwipeRight()
                          //}
                          withAnimation(.easeInOut(duration:0.45)){
                              hasAnswered = false
                          }
                          if viewModel.currentIndex == viewModel.showVocabularies.count - 1 {
                              router.push(.donePage(displayMode: .flashcard, chapterId: 0, subChapterId: 0))
                          }
                     }
                      
                      
                      /*
                     DispatchQueue.main.async {
                        viewModel.performSwipeRight()
                        hasAnswered = false
                        if viewModel.currentIndex == viewModel.showVocabularies.count - 1 {
                           router.push(.donePage(displayMode: .flashcard, chapterId: 0, subChapterId: 0))
                        }
                     }
                       */
                  }
               } tryAgainFunc: {
                   /*
                  withAnimation{
                     DispatchQueue.main.async {
                        hasAnswered = false
                     }
                  }
                    */
                   withAnimation(.easeInOut(duration:0.45)){
                       hasAnswered = false
                   }
               }
               .transition(.move(edge: .bottom))
            }
            else{
                BottomFlashcardContainerView(answer: $answer, isCorrect: $isCorrect, hasAnswered: $hasAnswered)
                  .transition(.move(edge: .bottom))
                  .onAppear {
                     isTransitioning = true
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Match your animation duration
                        isTransitioning = false
                     }
                  }
                  .onDisappear {
                     isTransitioning = true
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Match your animation duration
                        isTransitioning = false
                     }
                  }
            }
            
         }
         .frame(maxHeight: .infinity)
         .onAppear{
             print(" ")
             print("All Vocabularies 2 : ")
             for vocab in viewModel.showVocabularies{
                 print(vocab.pinyin)
             }
         }
         
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
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
      )
      .ignoresSafeArea(.container, edges: .bottom)
      .onAppear{
         viewModel.currentIndex = 0
          viewModel.currentIndexProgressBar = 0
         viewModel.reshuffleCards()
      }
   }
}

#Preview {
   FlashcardPageView()
      .environmentObject(Router())
      .environmentObject(FlashcardViewModel())
}



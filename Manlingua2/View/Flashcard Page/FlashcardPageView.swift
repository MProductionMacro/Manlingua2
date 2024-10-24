//
//  FlashcardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct FlashcardPageView: View {
   
   @EnvironmentObject var router: Router
   //@ObservedObject var viewModel1: StoryViewModel
   @StateObject var viewModel = FlashcardViewModel()
   @StateObject var singleton = UserDefaultSingleton.shared
   @State var tutorialOverlay: Int = 1
   
   @State var audioController = AudioController()
   
   var body: some View {
      ZStack {
         VStack {
            HStack(spacing: 4) {
               Button {
                  router.pop()
               } label: {
                  Image(systemName: "rectangle.portrait.and.arrow.right")
                     .resizable()
                     .frame(width: 29, height: 24)
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
                     
                     createFlashcardView(for: index)
                        .zIndex(Double(viewModel.showVocabularies.count - index))
                     
                     
                  }
                  
               }
            }
            //.gesture(createDragGesture())
            .padding(.bottom, 90)
            
            
            if viewModel.showMicrophone{
               FlashcardMicrophoneModalityView(
                  hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi,
                  responseText: $viewModel.apiResult, showMicrophone: $viewModel.showMicrophone, audioController: $audioController)
            }
            else if viewModel.checkResult() {
               FlashcardCorrect(showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
                  viewModel.performSwipeRight()
               }
            }
            else{
               FlashcardWrong(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
                  viewModel.performSwipeRight()
               }
            }
            
         }
         .background(.customBeige)
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
      .overlay{
         if viewModel.showDonePage {
            //FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
            DonePageView(currentPage: .flashCard, currentPart: .first)
               .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
               .background(.white)
         }
      }
   }
   
   private func createFlashcardView(for index: Int) -> some View {
      let flashcardView = FlashcardView(vocab: viewModel.showVocabularies[index], width: 300, height: 400)
         .frame(width: 300, height: 400)
      
      // Use AnyView to erase the type and maintain consistency
      var modifiedView: AnyView = AnyView(flashcardView)
      
      if index == viewModel.currentIndex {
         modifiedView = AnyView(modifiedView
            .opacity(1.0)
            .offset(x: viewModel.offset.width)
            .offset(y: viewModel.offset.height * 0.4)
            .rotationEffect(.degrees(viewModel.offset.width / 40.0))
            .animation(.spring(), value: viewModel.offset)
         )
      } else if index == viewModel.currentIndex - 1 {
         modifiedView = AnyView(modifiedView
            .opacity(1.0)
            .offset(x: -300 + viewModel.offset.width)
            .zIndex(Double(viewModel.showVocabularies.count - index))
            .animation(.spring(), value: viewModel.offset)
         )
      }
      
      return modifiedView
   }
   
   private func createDragGesture() -> some Gesture {
      DragGesture()
         .onChanged { gesture in
            viewModel.handleDragChanged(gesture: gesture)
         }
         .onEnded { gesture in
            viewModel.handleDragEnded(gesture: gesture)
         }
   }
}


#Preview {
   FlashcardPageView()
      .environmentObject(Router())
}


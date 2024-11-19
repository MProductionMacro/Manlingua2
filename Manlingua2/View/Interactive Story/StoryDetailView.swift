//
//  StoryDetailView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryDetailView: View {
   @EnvironmentObject private var viewModel: StoryViewModel
   @EnvironmentObject private var learnVM: LearnViewModel
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var router: Router
   
   @State private var showConfirmationAlert = false
   @State var currentIndex: Int = 0
   @State var tutorialOverlay: Int = 1
   @State var modalAppeared: Bool = false
   
   @State var hasAnswered: Bool = false
   @State var isCorrect: Bool = false
   @State var selectedAnswer: String? = nil
   
   @StateObject var singleton = SwiftDataServices.shared
   
   var chapterId: Int
   var subChapterId: Int
   //   var isFromHome: Bool
   
   var body: some View {
      GeometryReader { geometry in
         VStack(spacing: 16) {
            DismissAndIndexView(showConfirmationAlert: $showConfirmationAlert, currentIndex: $viewModel.currentIndex, chatCounts: viewModel.chat_example.count)
            
            ChatScrollView(currentIndex: $viewModel.currentIndex, hasAnswered: $hasAnswered, modalAppeared: $modalAppeared, chats: viewModel.chat_example) {
               router.push(.donePage(displayMode: .story(storyId: chapterId, subChapterId: subChapterId), chapterId: chapterId, subChapterId: subChapterId))
            }
            
            if hasAnswered{
               CorrectOrWrong(hanzi: viewModel.chat_example[viewModel.currentIndex].hanzi, pinyin: viewModel.chat_example[viewModel.currentIndex].pinyin, meaning: viewModel.chat_example[viewModel.currentIndex].meaning, isCorrect: isCorrect) {
                  viewModel.correctAction(modalAppeared: &modalAppeared, index: &viewModel.currentIndex, hasAnswered: &hasAnswered)
               } tryAgainFunc: {
                  viewModel.wrongAction(modalAppeared: &modalAppeared, index: &viewModel.currentIndex, hasAnswered: &hasAnswered)
               }
               .transition(.move(edge: .bottom))
            }else{
               BottomStoryContainerView(currentIndex: $viewModel.currentIndex, questionAppeared: $modalAppeared, selectedAnswer: $selectedAnswer, isCorrect: $isCorrect, hasAnswered: $hasAnswered, storyId: chapterId, chatType: viewModel.chat_example[viewModel.currentIndex].type, choices: viewModel.chat_example[viewModel.currentIndex].choice, realAnswer: viewModel.chat_example[viewModel.currentIndex].answer)
                  .transition(.move(edge: .bottom))
            }
         }
         .edgesIgnoringSafeArea(.bottom)
         .background(
            Image(.chatBackground)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
         )
         .onTapGesture { location in
            if !modalAppeared {
               let screenWidth = geometry.size.width
               let midPoint = screenWidth / 2
               
//               print(currentIndex)
               
               viewModel.onTapDetectionChat(location, midPoint, &viewModel.currentIndex)
            }
         }
         .overlay {
            TutorialOverlayView(tutorialOverlay: $tutorialOverlay, width: geometry.size.width * 0.7)
         }
      }
   }
}
//
//#Preview {
//   NavigationStack {
//      StoryDetailView(chapterId: 1, subChapterId: 1, isFromHome: true)
//         .environmentObject(StoryViewModel())
//         .environmentObject(LearnViewModel())
//         .environmentObject(HomeViewModel())
//         .environmentObject(Router())
//   }
//}


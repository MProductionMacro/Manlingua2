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
   
   @StateObject var singleton = CoreDataSingleton.shared
   
   var chapterId: Int
   var subChapterId: Int
   //   var isFromHome: Bool
   
   var body: some View {
      GeometryReader { geometry in
         VStack(spacing: 24) {
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
                         router.popToRoot()
                     }
                  )
               )
               
               Spacer()
               
               ProgressView(value: Double(currentIndex + 1) / Double(viewModel.chat_example.count))
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .greenNormalActive, unfilledColor: .progressBar))
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
            
            ChatScrollView(currentIndex: $currentIndex, hasAnswered: $hasAnswered, modalAppeared: $modalAppeared, chats: viewModel.chat_example) {
               viewModel.updateUserProgress(currentStory: chapterId, currentSubChapter: subChapterId)
               router.push(.donePage(displayMode: .story(storyId: chapterId, subChapterId: subChapterId)))
            }
            
            if hasAnswered{
               CorrectOrWrong(hanzi: viewModel.chat_example[currentIndex].hanzi, pinyin: viewModel.chat_example[currentIndex].pinyin, meaning: viewModel.chat_example[currentIndex].meaning, isCorrect: isCorrect) {
                  withAnimation{
                     DispatchQueue.main.async {
                        modalAppeared = false
                        currentIndex += 1
                        hasAnswered = false
                     }
                  }
               } tryAgainFunc: {
                  withAnimation{
                     DispatchQueue.main.async {
                        modalAppeared = false
                        currentIndex -= 1
                        hasAnswered = false
                     }
                  }
               }
               .transition(.move(edge: .bottom))
            }else{
               BottomStoryContainerView(currentIndex: $currentIndex, questionAppeared: $modalAppeared, selectedAnswer: $selectedAnswer, isCorrect: $isCorrect, hasAnswered: $hasAnswered, storyId: chapterId, chatType: viewModel.chat_example[currentIndex].type, choices: viewModel.chat_example[currentIndex].choice, realAnswer: viewModel.chat_example[currentIndex].answer)
                  .transition(.move(edge: .bottom))
            }
         }
         .edgesIgnoringSafeArea(.bottom)
         .background(
            Image(.chatBackground)
               .scaledToFill()
         )
         .onTapGesture { location in
            if !modalAppeared {
               let screenWidth = geometry.size.width
               let midPoint = screenWidth / 2
               
               print(currentIndex)
               
               viewModel.onTapDetectionChat(location, midPoint, &currentIndex)
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


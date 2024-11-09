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
   
   @StateObject var singleton = CoreDataSingleton.shared
   
   var chapterId: Int
   var subChapterId: Int
   var isFromHome: Bool
   
   var body: some View {
      GeometryReader { geometry in
         VStack(spacing: 24) {
            HStack(spacing: 4) {
               Button {
                  showConfirmationAlert = true
               } label: {
                  Image(systemName: "xmark")
                     .font(.system(size: 32))
                     .frame(width: 32, height: 32)
                     .foregroundStyle(.orange3)
               }.reusableAlert(
                  isPresented: $showConfirmationAlert,
                  alertData: AlertData(
                     type: .confirmation,
                     primaryAction: {
                        router.pop()
                     },
                     dismissAction: {
                        showConfirmationAlert = false
                     }
                  )
               )
               
               Spacer()
               
               ProgressView(value: Double(currentIndex + 1) / Double(viewModel.chat_example.count))
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
            }
            .padding(.horizontal)
            
            ChatScrollView(currentIndex: $currentIndex, chats: viewModel.chat_example) {
               viewModel.updateUserProgress(currentStory: chapterId, currentSubChapter: subChapterId)
               router.push(.donePage(currentPage: .story, currentPart: .first))
            }
            
            BottomStoryContainerView(currentIndex: $currentIndex, questionAppeared: $modalAppeared, storyId: chapterId, chatType: viewModel.chat_example[currentIndex].type, choices: viewModel.chat_example[currentIndex].choice, onAnswerSelected: { result in
               
            })
//            
//            if viewModel.chat_preview[currentIndex].type == .question {
//               ChatModalityView(chat: viewModel.chat_preview[currentIndex], modalAppeared: $modalAppeared, currentIndex: $currentIndex)
//            }
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


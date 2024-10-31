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
   
   var chapterId: Int
   var subChapterId: Int
   var isFromHome: Bool
   
   var body: some View {
      GeometryReader { geometry in
         ZStack {
            VStack(spacing: 24) {
               HStack(spacing: 4) {
                  Button {
                     router.pop()
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
                           
                        },
                        dismissAction: {
                           
                        }
                     )
                  )
                  
                  Spacer()
                  
                  ProgressView(value: Double(currentIndex + 1) / Double(viewModel.chat_example.count))
                     .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
                     .onChange(of: currentIndex) { _, newValue in
                        if newValue + 1 == viewModel.chat_example.count {
                           viewModel.updatingChapterProgress(isFromHome: isFromHome, chapterId: chapterId, subChapterId: subChapterId)
                        }
                     }
               }
               .padding(.horizontal)
               
               ChatScrollView(currentIndex: $currentIndex, chats: viewModel.chat_example) {
                  router.push(.journeyPage(storyId: chapterId))
               }
               
               if viewModel.chat_example[currentIndex].type == .question {
                  ChatModalityView(chat: viewModel.chat_example[currentIndex], modalAppeared: $modalAppeared, currentIndex: $currentIndex)
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
                  
                  viewModel.onTapDetectionChat(location, midPoint, &currentIndex)
               }
            }
            
            SidebarButton(chatIndex: $currentIndex, storyId: chapterId)
         }
         .overlay {
            TutorialOverlayView(tutorialOverlay: $tutorialOverlay, width: geometry.size.width * 0.7)
         }
      }
   }
}

//#Preview {
//   NavigationStack {
//      StoryDetailView()
//         .environmentObject(StoryViewModel())
//         .environmentObject(LearnViewModel())
//         .environmentObject(HomeViewModel())
//         .environmentObject(Router())
//   }
//}


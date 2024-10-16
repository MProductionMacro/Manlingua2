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
   
   @State var currentIndex: Int = 0
   @State var tutorialOverlay: Int = 1
   
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
                  }
                  
                  Spacer()
                  
                  ProgressView(value: Double(currentIndex + 1) / Double(viewModel.chat_example.count))
                     .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
               }
               .padding(.horizontal)
               
               ScrollView{
                  ForEach(0...currentIndex, id: \.self) { index in
                     let chat = viewModel.chat_example[index]
                     
                     BubbleChatView(chat: .constant(chat), type: chat.type)
                  }
               }
               
               Spacer()
            }
            .background(
               Image(.chatBackground)
                  .scaledToFill()
            )
            .onTapGesture { location in
               let screenWidth = geometry.size.width
               let midPoint = screenWidth / 2
               
               if location.x < midPoint {
                  // Tapped left screen, move to previous item
                  if currentIndex > 0 {
                     currentIndex -= 1
                  }
               } else {
                  // Tapped right screen, move to next item
                  if currentIndex < viewModel.chat_example.count - 1 {
                     currentIndex += 1
                  }
               }
            }
            
            SidebarButton()
         }
         .overlay {
            TutorialOverlayView(tutorialOverlay: $tutorialOverlay, width: geometry.size.width * 0.7)
         }
      }
   }
}

#Preview {
   StoryDetailView()
      .environmentObject(StoryViewModel())
      .environmentObject(LearnViewModel())
      .environmentObject(HomeViewModel())
      .environmentObject(Router())
}


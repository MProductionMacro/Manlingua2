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
   @State var modalAppeared: Bool = false
   
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
               
               ScrollViewReader { proxy in
                  ScrollView{
                     VStack(spacing: 16){
                        ForEach(0...currentIndex, id: \.self) { index in
                           let chat = viewModel.chat_example[index]
                           
                           BubbleChatView(chat: .constant(chat), type: chat.type)
                              .id(index)
                        }
                     }
                  }
                  .onChange(of: currentIndex) { oldValue, newValue in
                     proxy.scrollTo(newValue, anchor: .bottom)
                  }
               }
               .padding(.bottom, viewModel.chat_example[currentIndex].type == .question ? 0 : 64)
               
               if viewModel.chat_example[currentIndex].type == .question {
                  ChatModalityView(chat: viewModel.chat_example[currentIndex], modalAppeared: $modalAppeared, currentIndex: $currentIndex)
                     .onAppear {
                        modalAppeared = true
                     }
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


//
//  OnboardingPageView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 04/10/24.
//

import SwiftUI

struct OnboardingPageView: View {
   @State private var isShowingConfirmation: Bool = false
   @State private var isShowingDict: Bool = false
   @StateObject private var talkingAnimation = TalkingAnimation()
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var homeViewModel: HomeViewModel
   
   
   var body: some View {
      ZStack {
         Image(viewModel.currentStory.background).resizable().modifier(BackgroundImageModifier())
         HStack {
            BackButton(isShowingConfirmation: $isShowingConfirmation, isShowingDict: $isShowingDict)
               .padding(.bottom, 715)
               .padding(.leading, 22)
            Spacer()
         }
         .padding(.leading)
         TalkingView(images: ["Orange1","Orange2"],talkingAnimation: talkingAnimation)
            .onAppear {
               talkingAnimation.startTalking(duration: 5)
            }
            .padding(.trailing, 190)
            .padding(.leading, 20)
            .padding(.top, 250)
            .zIndex(0)
         Image("OrangeStay")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .padding(.leading, 190)
            .padding(.top, 250)
            .zIndex(0)
         
         
         BubbleChatNext(text: viewModel.currentStory.onboarding[viewModel.currentOnboardingIndex].text, pos: viewModel.currentStory.onboarding[viewModel.currentOnboardingIndex].text, viewModel: viewModel)
            .padding(.bottom, 100)
            .zIndex(0)
         
         if isShowingConfirmation {
            Color.black.opacity(0.4)
               .edgesIgnoringSafeArea(.all)
            
            ConfirmationView(isShowingConfirmation: $isShowingConfirmation, homeVM: homeViewModel)
               .frame(width: 313, height: 282)
               .transition(.scale)
               .zIndex(100)
               .padding(.bottom, 85)
         }
         if isShowingDict {
            Color.black.opacity(0.4)
               .edgesIgnoringSafeArea(.all)
            
            DictionaryView()
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .transition(.scale)
               .zIndex(100)
         }
      }
   }
}

#Preview {
   OnboardingPageView()
      .environmentObject(StoryViewModel())
      .environmentObject(HomeViewModel())
}

struct BackgroundImageModifier: ViewModifier {
   func body(content: Content) -> some View {
      content
         .scaledToFill()
         .ignoresSafeArea()
   }
}

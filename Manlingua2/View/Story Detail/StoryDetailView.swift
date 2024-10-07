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
    
    var body: some View {
        VStack {
            switch viewModel.currentStage {
            case .onboarding:
                OnboardingPageView()
            case .flashcard:
                FlashcardSwipeView(isShowingFlashcard: .constant(false), viewModel: viewModel, homeViewModel: homeViewModel)
               //MARK: Sementara
            case .quiz1:
               OnboardingPageView()
            case .quiz2:
               OnboardingPageView()
            case .toneTest:
               ToneView2()
            case .conversation:
               OnboardingPageView()
            case .completed:
               TabPageView()
            }
        }
    }
}


#Preview {
    StoryDetailView()
      .environmentObject(StoryViewModel())
      .environmentObject(LearnViewModel())
      .environmentObject(HomeViewModel())
}

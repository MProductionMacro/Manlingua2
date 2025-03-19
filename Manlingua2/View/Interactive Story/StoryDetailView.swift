//
//  StoryDetailView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryDetailView: View {
   @EnvironmentObject private var viewModel: StoryViewModel
   @EnvironmentObject private var router: Router
   
   @State private var showConfirmationAlert = false
   @State var currentIndex: Int = 0
   @State var modalAppeared: Bool = false
   @State var hasAnswered: Bool = false
   @State var isCorrect: Bool = false
   @State var selectedAnswer: String? = nil
   @State var tutorialOverlay: Int = 1
   
   @State private var isTransitioning: Bool = false // Prevents skipping during animations
   @State private var isTransitionComplete: Bool = true // Tracks if the view can handle taps
   
   var chapterId: Int
   var subChapterId: Int
   
   var body: some View {
      GeometryReader { geometry in
         VStack(spacing: 16) {
            DismissAndIndexView(
               showConfirmationAlert: $showConfirmationAlert,
               currentIndex: $viewModel.currentIndex,
               chatCounts: viewModel.chat_example.count
            )
            
            ChatScrollView(
               currentIndex: $viewModel.currentIndex,
               hasAnswered: $hasAnswered,
               modalAppeared: $modalAppeared,
               chats: viewModel.chat_example
            ) {
               router.push(.donePage(
                  displayMode: .story(storyId: chapterId, subChapterId: subChapterId),
                  chapterId: chapterId,
                  subChapterId: subChapterId
               ))
            }
            
            if hasAnswered {
               CorrectOrWrong(
                  isSpeakingQuestion: .constant(false),
                  hanzi: viewModel.chat_example[viewModel.currentIndex].hanzi,
                  pinyin: viewModel.chat_example[viewModel.currentIndex].pinyin,
                  meaning: viewModel.chat_example[viewModel.currentIndex].meaning,
                  isCorrect: isCorrect,
                  type: viewModel.chat_example[viewModel.currentIndex].choice != nil ? .writingQuestion : .speakingQuestion
               ) {
                  handleCorrect()
               } tryAgainFunc: {
                  handleTryAgain()
               }
               .transition(.move(edge: .bottom))
            } else {
               BottomStoryContainerView(
                  currentIndex: $viewModel.currentIndex,
                  questionAppeared: $modalAppeared,
                  selectedAnswer: $selectedAnswer,
                  isCorrect: $isCorrect,
                  hasAnswered: $hasAnswered,
                  isSpeakingQuestion: .constant(false),
                  storyId: chapterId,
                  chatType: viewModel.chat_example[viewModel.currentIndex].type,
                  choices: viewModel.chat_example[viewModel.currentIndex].choice,
                  realAnswer: viewModel.chat_example[viewModel.currentIndex].answer
               )
               .transition(.move(edge: .bottom))
               .onTapGesture{ location in
                   
               }
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
            handleTap(location: location, midPoint: geometry.size.width / 2)
         }
         .overlay {
            TutorialOverlayView(tutorialOverlay: $tutorialOverlay, width: geometry.size.width * 0.6)
         }
      }
   }
    
    private func handleCorrect() {
       guard !isTransitioning else { return }
       isTransitioning = true
       withAnimation {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
             isTransitioning = false
             isTransitionComplete = true // Allow new taps
          }
          viewModel.correctAction(modalAppeared: &modalAppeared, hasAnswered: &hasAnswered)
       }
    }
    
    private func handleTryAgain() {
       guard !isTransitioning else { return }
       isTransitioning = true
       withAnimation {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
             isTransitioning = false
             isTransitionComplete = true // Allow new taps
          }
          //viewModel.wrongAction(modalAppeared: &modalAppeared, hasAnswered: &hasAnswered)
          viewModel.tryAgainAction(modalAppeared: &modalAppeared, hasAnswered: &hasAnswered)
       }
    }
    
    private func handleTap(location: CGPoint, midPoint: CGFloat) {
       guard isTransitionComplete, !isTransitioning else { return }
       isTransitionComplete = false // Prevent further taps until resolved
       if !modalAppeared {
          withAnimation {
             viewModel.onTapDetectionChat(location, midPoint) {
                //viewModel.saveDailyProgress()
                router.push(.donePage(
                   displayMode: .story(storyId: chapterId, subChapterId: subChapterId),
                   chapterId: chapterId,
                   subChapterId: subChapterId
                ))
                viewModel.updateUserProgress(currentStory: chapterId, currentSubChapter: subChapterId)

             }
          }
       }
       else if location.x < midPoint{
           modalAppeared = false
           //hasAnswered = false
           withAnimation {
              viewModel.onTapDetectionChat(location, midPoint) {
                 //viewModel.saveDailyProgress()
                 router.push(.donePage(
                    displayMode: .story(storyId: chapterId, subChapterId: subChapterId),
                    chapterId: chapterId,
                    subChapterId: subChapterId
                 ))
                 viewModel.updateUserProgress(currentStory: chapterId, currentSubChapter: subChapterId)
              }
           }
           //hasAnswered = true
           hasAnswered = false
       }
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          isTransitionComplete = true // Re-enable taps after animation
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

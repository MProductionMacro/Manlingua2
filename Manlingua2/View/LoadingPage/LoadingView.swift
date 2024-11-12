//
//  LoadingView.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 29/10/24.
//

import SwiftUI

struct LoadingView: View {
   var chapterId: Int
   var subChapterId: Int
   
   @State private var isLoading = true
   @State private var progressValue: CGFloat = 0.0
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var storyVM: StoryViewModel
   
   var body: some View {
      ZStack {
         
         Image(.chatBackground)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
         
         VStack {
            Spacer()
            Image("Animate")
               .frame(width: 60, height: 60)
               .padding(.bottom, 70)
            VStack(spacing: 20) {
               //               ProgressBar(progress: progressValue)
               //                  .frame(width: 300, height: 8)
               ProgressView(value: progressValue, total: 1)
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
            }
            Spacer()
         }
         .padding()
      }
      .onAppear {
         animateProgress()
      }
   }
   
   private func animateProgress() {
      withAnimation(.easeInOut(duration: 2.5)) {
         progressValue = 1.0
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
         if progressValue >= 1.0 {
            storyVM.loadChat(storyId: chapterId, subChapterId: subChapterId)
            
            router.push(.storyPage(chapterId: chapterId, subChapterId: subChapterId))
         }
      }
   }
}

#Preview{
   LoadingView(chapterId: 1, subChapterId: 1)
      .environmentObject(Router())
      .environmentObject(StoryViewModel())
}

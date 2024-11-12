//
//  LoadingView.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 29/10/24.
//

import SwiftUI

struct LoadingView: View {
   @EnvironmentObject var router: Router
   @State private var isLoading = true
   @State private var progressValue: CGFloat = 0.0
    var screen: Screen
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
                    .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .greenNormalActive, unfilledColor: .progressBar))
            }
            Spacer()
         }
         .padding()
      }
      .onAppear {
         animateProgress()
         navigatePage()
      }
   }
   
    private func navigatePage(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5)  {
            router.push(screen)
        }
    }
    
   private func animateProgress() {
      withAnimation(.easeInOut(duration: 2.5)) {
         progressValue = 1.0
      }
       
   }
}

#Preview{
    LoadingView(screen: .pinyinFinal)
        .environmentObject(Router())
}

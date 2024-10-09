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
         HStack {
            Text("X")
            
            Spacer()
            
            ProgressView(value: 0.5)
               .progressViewStyle(CustomProgressViewStyle(height: 10, filledColor: .green, unfilledColor: .customLighterGray))
         }
         
         Spacer()
      }
      .padding(.horizontal)
   }
}

#Preview {
   StoryDetailView()
      .environmentObject(StoryViewModel())
      .environmentObject(LearnViewModel())
      .environmentObject(HomeViewModel())
}

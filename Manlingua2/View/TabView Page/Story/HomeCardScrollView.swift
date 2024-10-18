//
//  HomeCardScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardScrollView: View {
   @EnvironmentObject var viewModel: HomeViewModel
   
   let currentChapter: Int = StoryProgressManager.getCurrentChapter()
   
   var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
         HStack(spacing: 24) {
            ForEach(viewModel.stories_example, id: \.id) { stories in
               let isDisabled = stories.id > currentChapter
               
               HomeCardView(
                  homeCard: .story1Thumbnail,
                  isDisabled: isDisabled,
                  isComplete: false,
                  story: stories
               )
            }
         }
         .padding(.horizontal, 24)
         .padding(.bottom, 32)
         .padding(.top, 36)
      }
      .ignoresSafeArea()
   }
}

#Preview {
   HomeCardScrollView()
      .environmentObject(HomeViewModel())
}

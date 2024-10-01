//
//  HomeCardScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardScrollView: View {
   @ObservedObject var homeViewModel: HomeViewModel
   @ObservedObject var viewModel: StoryViewModel
   
   var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
         HStack(spacing: 24) {
            HomeCardView(
               homeViewModel: homeViewModel,
               viewModel: viewModel,
               homeCard: .story1Thumbnail,
               story: "Story 1",
               storyName: "Go to Chinese Hotpot\nRestaurant",
               isDisabled: false,
               isComplete: false
            )
            
            HomeCardView(
               homeViewModel: homeViewModel,
               viewModel: viewModel,
               homeCard: .story2Thumbnail,
               story: "Story 2",
               storyName: "Go to Market\n",
               isDisabled: true,
               isComplete: false
            )
         }
         .padding(.horizontal)
//         .frame(maxHeight: .infinity, alignment: .top)
      }
//      .frame(maxHeight: .infinity, alignment: .top)
   }
   
}

#Preview {
   HomeCardScrollView(homeViewModel: HomeViewModel(), viewModel: StoryViewModel())
}

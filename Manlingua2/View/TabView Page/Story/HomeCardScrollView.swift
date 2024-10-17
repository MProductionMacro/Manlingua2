//
//  HomeCardScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardScrollView: View {
   @EnvironmentObject var viewModel: HomeViewModel
   
   var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
         HStack(spacing: 24) {
            ForEach(viewModel.stories_example, id: \.id) { stories in
               HomeCardView(
                  homeCard: .story1Thumbnail,
                  storyName: "Go to Chinese Hotpot\nRestaurant",
                  isDisabled: false,
                  isComplete: false,
                  story: stories
               )
            }
         }
         .padding(.horizontal, 24)
         .padding(.bottom, 32)
         .padding(.top, 36)
//         .frame(maxHeight: .infinity, alignment: .top)
      }
//      .frame(maxHeight: .infinity, alignment: .top)
      .ignoresSafeArea()
   }
   
}

#Preview {
   HomeCardScrollView()
      .environmentObject(HomeViewModel())
}

//
//  HomeCardScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardScrollView: View {
   @EnvironmentObject var viewModel: HomeViewModel
   
    @StateObject var singleton = UserDefaultSingleton.shared

   var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
         HStack(spacing: 24) {
            ForEach(viewModel.stories_example, id: \.id) { stories in
               /*
               HomeCardView(
                  homeCard: .story1Thumbnail,
                  isDisabled: stories.id > singleton.latestStory,
                  isComplete: false,
                  story: stories
               )
                */
                if stories.id <= singleton.latestStory{
                    HomeCardView(
                       homeCard: .story1Thumbnail,
                       isDisabled: false,
                       isComplete: false,
                       story: stories
                    )
                }
                else{
                    HomeCardView(
                       homeCard: .story1Thumbnail,
                       isDisabled: true,
                       isComplete: false,
                       story: stories
                    )
                }
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

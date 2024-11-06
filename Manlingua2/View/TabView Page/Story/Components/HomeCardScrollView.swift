//
//  HomeCardScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardScrollView: View {
   @EnvironmentObject var viewModel: HomeViewModel
   
   @StateObject var singleton = CoreDataSingleton.shared
   
   var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
         HStack(spacing: 24) {
            ForEach(viewModel.stories_example, id: \.id) { stories in
               HomeCardView(
                  homeCard: .story1Thumbnail,
                  isDisabled: stories.id <= singleton.latestStory ? false : true,
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
      .onAppear {
         print(singleton.latestStory)
      }
   }
}

#Preview {
   HomeCardScrollView()
      .environmentObject(HomeViewModel())
}

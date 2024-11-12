//
//  HomeCardScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardListView: View {
   @EnvironmentObject var viewModel: HomeViewModel
   
   @StateObject var singleton = CoreDataSingleton.shared
   
   var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
         HStack(spacing: 24) {
            ForEach(viewModel.stories_example, id: \.id) { stories in
               HomeCardView(
                  homeCard: .story1Thumbnail,
                  isComplete: false,
                  isDisabled: .constant(stories.id <= singleton.latestStory ? false : true),
                  story: stories
               )
            }
         }
         .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
         .padding(.bottom)
         .padding(.top, UIScreen.main.bounds.height * 0.035)
      }
      .ignoresSafeArea()
      .onAppear {
         print(singleton.latestStory)
      }
   }
}

#Preview {
   HomeCardListView()
      .environmentObject(HomeViewModel())
}

//
//  TabPageView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct TabPageView: View {
   @State private var selectedTab = 0
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var learnVM: LearnViewModel
   
   var body: some View {
      TabView(selection: $selectedTab) {
         StoryListView(homeViewModel: homeViewModel, viewModel: viewModel)
            .tabItem {
               Label {
                  Text("Story")
                     .foregroundStyle(selectedTab == 0 ? Color.orange3 : Color.gray)
               } icon: {
                  Image("story")
                     .resizable()
                     .foregroundStyle(selectedTab == 0 ? Color.orange3 : Color.gray)
               }
            }
         
         PinyinView(viewModel: learnVM)
            .tabItem {
               Label {
                  Text("Pinyin")
                     .foregroundStyle(selectedTab == 0 ? Color.orange3 : Color.gray)
               } icon: {
                  Image("pinyin")
                     .resizable()
                     .foregroundStyle(selectedTab == 0 ? Color.orange3 : Color.gray)
               }
            }
      }
      .tint(.orange3)
   }
}

#Preview {
   TabPageView()
      .environmentObject(StoryViewModel())
      .environmentObject(HomeViewModel())
      .environmentObject(LearnViewModel())
}

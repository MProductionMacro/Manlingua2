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
   
   @State var hanzi: String = "您好， 明先生。我们商量价格。"
   @State var pinyin: String = "nín hǎo, míng xiānshēng. wǒmen shāngliáng jiàgé"
   
   var body: some View {
      ZStack {
         VStack(spacing: 24) {
            HStack(spacing: 4) {
               Button {
                  
               } label: {
                  Image(systemName: "xmark")
                     .font(.system(size: 32))
                     .frame(width: 32, height: 32)
                     .foregroundStyle(.orange3)
               }
               
               Spacer()
               
               ProgressView(value: 0.5)
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
            }
            
            BubbleChatView(pinyin: $pinyin, hanzi: $hanzi)
               .padding(.leading, 4)
            
            Spacer()
         }
         .padding(.horizontal)
         .background(.customBeige)
         
         SidebarButton()
      }
   }
}

#Preview {
   StoryDetailView()
      .environmentObject(StoryViewModel())
      .environmentObject(LearnViewModel())
      .environmentObject(HomeViewModel())
}

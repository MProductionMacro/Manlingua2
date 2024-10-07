//
//  StoryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryListView: View {
   @ObservedObject var homeViewModel: HomeViewModel
   @ObservedObject var viewModel: StoryViewModel
   
   var body: some View {
      //TODO: Beberapa size masih hard coded
      VStack(spacing: 0) {
         VStack(alignment: .leading) {
            //               Spacer()
            Text("Cerita seru apa yang ingin kamu")
               .fontWeight(.semibold)
               .foregroundStyle(.white)
            Text("Coba Jelajah?")
               .font(.judulBesar())
               .foregroundStyle(.white)
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .padding(.leading, 20)
         .padding(.top)
         .padding(.bottom, 24)
         
         ZStack {
            Rectangle()
               .fill(.white)
               .clipShape(CustomRoundedRectangle(cornerRadius: 32))
            
            HomeCardScrollView(homeViewModel: homeViewModel, viewModel: viewModel)
//               .padding(.top, 40)
//               .ignoresSafeArea()
         }
         .ignoresSafeArea()
      }
      .background(Image(.homeBackground))
   }
}

#Preview {
   StoryListView(homeViewModel: HomeViewModel(), viewModel: StoryViewModel())
}

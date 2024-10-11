//
//  HomeCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardView: View {
   @ObservedObject var homeViewModel: HomeViewModel
   @ObservedObject var viewModel: StoryViewModel
   @State var homeCard: ImageResource
   @State var story: String
   @State var storyName: String
   @State var isDisabled: Bool
   @State var isComplete: Bool
   
   var body: some View {
      //TODO: Framenya hard coded, takut ga responsive
      VStack(alignment: .center) {
         Image(.story1Thumbnail)
         
         Text("Cerita 1")
            .font(.subJudul())
            .foregroundStyle(.black)
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
         
         VStack(alignment: .leading) {
            Text("Dasar Negosiasi")
               .font(.judulBiasa())
               .foregroundStyle(.black)
               
            
            Text("谈   判   基  础")
               .font(.subJudul())
            
            Text("tán  pàn   jī   chǔ")
               .font(.pinyin())
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .padding(.top, 8)
         .padding(.bottom, 16)
         
         HStack {
            PrimaryButtonView(homeViewModel: homeViewModel,isDisabled: isDisabled)
            
            CardMenuButtonView(isDisabled: isDisabled)
         }
      }
      .padding()
      .background(.white)
      .clipShape(.rect(cornerRadius: 24))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
      .padding(.top, 30)
      .frame(maxHeight: .infinity, alignment: .top)
   }
}

#Preview {
   HomeCardView(homeViewModel: HomeViewModel(), viewModel: StoryViewModel(), homeCard: .story1Thumbnail, story: "Story 1", storyName: "Go to Chinese Hotpot\nRestaurant", isDisabled: false, isComplete: false)
}

//
//  StoryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryListView: View {
   var body: some View {
      //      TODO: Beberapa size masih hard coded
      ScrollView{
         VStack(spacing: 0) {
            VStack(alignment: .leading) {
               Text("Cerita seru apa yang ingin kamu")
                  .fontWeight(.semibold)
                  .foregroundStyle(.white)
                  .font(.judulBiasa())
               
               Text("Coba Jelajah?")
                  .font(.judulSedang())
                  .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
   //         .padding(.top)
            .padding(.bottom)
            
            VStack {
//               ScrollView(showsIndicators: false) {
                  HomeCardListView()
                  KataKataView()
                  TantanganView()
//               }
               .padding(.bottom, 64)
            }
            .background(.blankBackground)
//            .ignoresSafeArea()
            .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft]))
         }
         .padding(.top, 64)
      }
      .ignoresSafeArea()
      .background(
         Image(.profilePage)
//            .resizable()
//            .scaledToFill()
      )
   }
}

#Preview {
   StoryListView()
      .environmentObject(HomeViewModel())
      .environment(\.colorScheme, .dark)
}

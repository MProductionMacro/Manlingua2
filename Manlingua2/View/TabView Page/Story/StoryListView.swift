//
//  StoryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryListView: View {
    @EnvironmentObject private var router: Router
   var body: some View {
      //      TODO: Beberapa size masih hard coded
      ScrollView(showsIndicators: false){
         VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("Cerita seru apa yang ingin kamu".localized)
                  .fontWeight(.semibold)
                  .foregroundStyle(.white)
                  .font(.judulBiasa())
               
                Text("Coba Jelajah?".localized)
                  .font(.judulSedang())
                  .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
//            .padding(.top)
            .padding(.bottom)
            
            VStack {
//               ScrollView(showsIndicators: false) {
                  HomeCardListView()
                  KataKataView()
                  TantanganView()
//               }
            }
            .padding(.bottom, UIScreen.main.bounds.height * 0.1)
            .background(
               Color.blankBackground
                  .frame(maxHeight: .infinity)
//                  .ignoresSafeArea()
            )
            .ignoresSafeArea()
            .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft]))
         }
         .padding(.top, 64)
      }
      .ignoresSafeArea()
      .background(
         Image(.profilePage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
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


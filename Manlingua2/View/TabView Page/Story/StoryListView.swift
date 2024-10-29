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
      VStack(spacing: 0) {
         VStack(alignment: .leading) {
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
         .padding(.bottom, 27)
         
         VStack(spacing: 32) {
            ScrollView(showsIndicators: false) {
               HomeCardScrollView()
               KataKataView()
               TantanganView()
            }
            .padding(.bottom, 64)
            .ignoresSafeArea()
         }
         .background(.white)
         .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft]))
      }
      .padding(.top, 64)
      .ignoresSafeArea()
      .background(Image(.homeBackground).resizable().scaledToFill())
   }
}

#Preview {
   StoryListView()
      .environmentObject(HomeViewModel())
}

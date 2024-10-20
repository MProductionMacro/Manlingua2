//
//  KataKataView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 14/10/24.
//

import SwiftUI

struct KataKataView: View {
   @EnvironmentObject var router: Router
   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         Text("Kata-kata")
            .font(.judulBiasa())
            .padding(.leading, 24)
         
         //         ScrollView(.horizontal, showsIndicators: false){
         HStack(spacing: 24) {
            Button {
               router.push(.flashcardPage)
            } label: {
               VStack {
                  VStack(alignment: .leading, spacing: 10) {
                     Image(.flashcard)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)
                        .padding(12)
                        .background(.orange2)
                        .clipShape(.circle)
                     
                     
                     Text("Flashcard")
                        .font(.pinyin())
                        .foregroundStyle(.black)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding()
               }
               .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
               .background(.white)
               .clipShape(.rect(cornerRadius: 16))
               .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
            }
            
            Button {
               router.push(.dictionary(judul: "Kata Favorit", storyId: 1, showFavoriteVocab: true))
            } label: {
               VStack {
                  VStack(alignment: .leading, spacing: 10) {
                     Image(.love)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)
                        .padding(12)
                        .background(.orange2)
                        .clipShape(.circle)
                     
                     Text("Favorit")
                        .font(.pinyin())
                        .foregroundStyle(.black)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding()
               }
               .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
               .background(.white)
               .clipShape(.rect(cornerRadius: 16))
               .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
            }
            
            Button {
               
            } label: {
               VStack {
                  VStack(alignment: .leading, spacing: 10) {
                     Image(.catatan)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)
                        .padding(12)
                        .background(.orange2)
                        .clipShape(.circle)
                     
                     Text("Catatan")
                        .font(.pinyin())
                        .foregroundStyle(.black)
                  }
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding()
               }
               .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
               .background(.white)
               .clipShape(.rect(cornerRadius: 16))
               .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
            }
            
         }
         .padding(.vertical)
         .padding(.leading, 24)
         //         }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.bottom)
   }
}

#Preview {
   KataKataView()
}

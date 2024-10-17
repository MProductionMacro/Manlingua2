//
//  KataKataView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 14/10/24.
//

import SwiftUI

struct KataKataView: View {
   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         Text("Kata-kata")
            .font(.judulBiasa())
            .padding(.leading, 24)
         
         ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 24) {
               Button {
                  
               } label: {
                  VStack {
                     VStack {
                        Text("Harian")
                           .font(.subJudul())
                           .foregroundStyle(.black)
                        
                        Image(.calendarStory)
                     }
                     .padding(.horizontal, 34)
                     .padding(.vertical)
                  }
                  .background(.white)
                  .clipShape(.rect(cornerRadius: 16))
                  .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
                  .padding(.vertical)
                  .padding(.leading, 24)
               }
               
               Button {
                  
               } label: {
                  VStack {
                     VStack {
                        Text("Favorit")
                           .font(.subJudul())
                           .foregroundStyle(.black)
                        
                        Image(.favoriteStory)
                     }
                     .padding(.horizontal, 34)
                     .padding(.vertical)
                     .background(.white)
                     .clipShape(.rect(cornerRadius: 16))
                     .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
                  }
               }
               
               Button {
                  
               } label: {
                  VStack {
                     VStack {
                        Text("Catatan")
                           .font(.subJudul())
                           .foregroundStyle(.black)
                        
                        Image(.noteStory)
                     }
                     .padding(.horizontal, 34)
                     .padding(.vertical)
                  }
                  .background(.white)
                  .clipShape(.rect(cornerRadius: 16))
                  .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
               }
               
            }
         }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.bottom)
   }
}

#Preview {
   KataKataView()
}

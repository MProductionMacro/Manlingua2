//
//  TantanganView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 17/10/24.
//

import SwiftUI

struct TantanganView: View {
    var body: some View {
       VStack(alignment: .leading, spacing: 0) {
          Text("Tantangan")
             .font(.judulBiasa())
             .padding(.leading, 24)
          
          HStack(spacing: 24) {
             Button {
                
             } label: {
                VStack {
                   VStack(alignment: .leading, spacing: 10) {
                      Circle()
                         .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.width * 0.08)
                      
                      Text("Flashcard")
                         .font(.pinyin())
                         .foregroundStyle(.black)
                   }
                   .padding()
                   //                     .padding(.horizontal, 34)
                   //                     .padding(.vertical)
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
                   VStack(alignment: .leading, spacing: 10) {
                      Circle()
                         .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.width * 0.08)
                      
                      Text("Flashcard")
                         .font(.pinyin())
                         .foregroundStyle(.black)
                   }
                   .padding()
                }
                .background(.white)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
             }
             
          }
          //         }
       }
       .frame(maxWidth: .infinity, alignment: .leading)
       .padding(.bottom)
    }
}

#Preview {
    TantanganView()
}

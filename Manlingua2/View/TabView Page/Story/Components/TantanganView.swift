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
                      Image(.foto)
                         .resizable()
                         .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)
                         .padding(12)
                         .background(.gold1)
                         .clipShape(.circle)
                      
                      
                      Text("Foto")
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
                      Image(.percakapan)
                         .resizable()
                         .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.width * 0.05)
                         .padding(12)
                         .background(.gold1)
                         .clipShape(.circle)
                      
                      
                      Text("Percakapan")
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
       }
       .frame(maxWidth: .infinity, alignment: .leading)
       .padding(.bottom)
    }
}

#Preview {
    TantanganView()
}

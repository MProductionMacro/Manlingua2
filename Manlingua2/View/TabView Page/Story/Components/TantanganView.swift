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
                      Image(systemName: "camera")
                         .frame(width: UIScreen.main.bounds.width * 0.03, height: UIScreen.main.bounds.width * 0.03)
                         .foregroundStyle(.orange1)
                         .font(.pinyin())
                         .bold()
                         .padding(UIScreen.main.bounds.width * 0.025)
                         .background(.orange2.opacity(0.35))
                         .clipShape(.circle)
                      
                      Text("Foto")
                         .font(.pinyin())
                         .foregroundStyle(.black)
                   }
                   .frame(width: UIScreen.main.bounds.width * 0.14, height: UIScreen.main.bounds.height * 0.075, alignment: .topLeading)
                   .padding()
                }
                .background(.white)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
             }
             
             Button {
                
             } label: {
                VStack {
                   VStack(alignment: .leading, spacing: 10) {
                      Image(systemName: "bubble.left.and.text.bubble.right")
                         .frame(width: UIScreen.main.bounds.width * 0.03, height: UIScreen.main.bounds.width * 0.03)
                         .foregroundStyle(.orange1)
                         .font(.pinyin())
                         .bold()
                         .padding(UIScreen.main.bounds.width * 0.025)
                         .background(.orange2.opacity(0.35))
                         .clipShape(.circle)
                      
                      Text("Simulasi")
                         .font(.pinyin())
                         .foregroundStyle(.black)
                   }
                   .frame(width: UIScreen.main.bounds.width * 0.14, height: UIScreen.main.bounds.height * 0.075, alignment: .topLeading)
                   .padding()
                }
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

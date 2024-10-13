//
//  TryAgainHanzi.swift
//  HXD
//
//  Created by Ferdinand Jacques on 09/08/24.
//

import SwiftUI

struct Wrong: View {
   var hanzi: String
   var pinyin: String
   var meaning: String
   @ObservedObject var viewModel: StoryViewModel
   
   var body: some View {
      VStack(alignment: .leading, spacing: 24) {
         VStack(alignment: .leading) {
            HStack(spacing: 12) {
               Button {
                  
               } label: {
                  Image(systemName: "waveform")
                     .foregroundStyle(.white)
                     .font(.judulBiasa())
                     .padding(12)
                     .background(.orange3)
                     .cornerRadius(16)
               }
               
               Image(systemName: "x.circle.fill")
                  .foregroundColor(.redNormal)
                  .font(.title)
               
               VStack(alignment: .leading) {
                  Text("wán quán zhèng què!")
                     .foregroundStyle(.redNormal)
                     .font(.pinyin())
                     .fontWeight(.bold)
                  
                  Text("完全正确")
                     .foregroundStyle(.redNormal)
                     .font(.judulBiasa())
                     .fontWeight(.regular)
               }
            }
            
            HStack {
               Text("\(hanzi) artinya '\(meaning)'")
                  .foregroundStyle(.black)
                  .font(.subJudul())
            }
         }
         
         HStack(spacing: 16) {
            TryAgainButton(action: {
               
            })
            
            ContinueButton(action: {
               
            })
         }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.vertical, 24)
      .background(.redLight)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   Wrong(hanzi: "猫", pinyin: "Māo", meaning: "Cat", viewModel: StoryViewModel())
}

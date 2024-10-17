//
//  View.swift
//  HXD
//
//  Created by Ferdinand Jacques on 01/08/24.
//

import SwiftUI

struct Correct: View {
   var hanzi: String
   var pinyin: String
   var meaning: String
   
   @Binding var modalAppeared: Bool
   @Binding var currentIndex: Int
   
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
               
               Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(Color.green2)
                  .font(.title)
               
               VStack(alignment: .leading) {
                  Text("wán quán zhèng què!")
                     .foregroundStyle(Color.green2)
                     .font(.pinyin())
                     .fontWeight(.bold)
                  
                  Text("完全正确")
                     .foregroundStyle(.green2)
                     .font(.judulBiasa())
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
               modalAppeared = false
               currentIndex -= 1
            })
            
            ContinueButton(action: {
               modalAppeared = false
               currentIndex += 1
            })
         }
      }
      .edgesIgnoringSafeArea(.bottom)
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.top, 24)
      .padding(.bottom, 36)
      .background(.greenLight)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   Correct(hanzi: "猫", pinyin: "Māo", meaning: "How many people", modalAppeared: .constant(true), currentIndex: .constant(1))
}

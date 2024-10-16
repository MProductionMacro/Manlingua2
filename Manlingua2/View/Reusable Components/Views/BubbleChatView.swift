//
//  BubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/10/24.
//

import SwiftUI

struct BubbleChatView: View {
   @Binding var pinyin: String
   @Binding var hanzi: String
   
   var body: some View {
      //      GeometryReader { geometry in
      HStack(spacing: 0) {
         Image(.orange2)
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height  * 0.08)
         
         HStack(alignment: .top, spacing: 0) {
            LeftCustomTriangle(cornerRadius: 16)
               .fill(.white)
               .frame(width: UIScreen.main.bounds.width * 0.04, height: UIScreen.main.bounds.height * 0.03)
               .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 2) {
               Text(pinyin)
                  .font(.pinyin())
                  .foregroundColor(.gray)
               
               // Chinese characters
               Text(hanzi)
                  .font(.hanzi())
                  .foregroundColor(.black)
            }
            .padding(8)
            .background(
               ZStack(alignment: .topLeading) {
                  RoundedRectangle(cornerRadius: 8)
                     .fill(.white)
               }
            )
         }
         
         Spacer()
      }
      //      }
   }
}

#Preview {
   BubbleChatView(pinyin: .constant("Pinyin"), hanzi: .constant("Hanzi"))
      .background(Color.black.opacity(0.5))
}

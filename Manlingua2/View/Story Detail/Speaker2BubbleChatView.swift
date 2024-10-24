//
//  Speaker2BubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct Speaker2BubbleChatView: View {
   var hanzi: String
   var pinyin: String
   
   var body: some View {
      HStack{
         Spacer()
         
         HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
               Text(pinyin)
                  .font(.pinyin())
                  .fontWeight(.bold)
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
            
            RightCustomTriangle(cornerRadius: 16)
               .fill(.white)
               .frame(width: UIScreen.main.bounds.width * 0.03, height: UIScreen.main.bounds.height * 0.02)
               .padding(.top, 8)
         }
         
         Image(.orangeSpeaker2)
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height  * 0.08)
      }
   }
}

#Preview {
   Speaker2BubbleChatView(hanzi: "Halo", pinyin: "Halo")
      .background(.black)
}

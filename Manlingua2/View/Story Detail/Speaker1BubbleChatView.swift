//
//  Speaker1BubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct Speaker1BubbleChatView: View {
   var hanzi: String
   var pinyin: String
   
   var body: some View {
      HStack{
         Image(.orangeSpeaker1)
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
   }
}

#Preview {
   Speaker1BubbleChatView(hanzi: "Halo", pinyin: "Halo")
}

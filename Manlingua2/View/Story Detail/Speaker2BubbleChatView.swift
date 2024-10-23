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
   var meaning: String
   
   @State var isShowingMeaning = false
   
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
                  .overlay {
                     DottedUnderline()
                        .frame(height: UIScreen.main.bounds.height * 0.015)
                        .offset(y: UIScreen.main.bounds.height * 0.02)
                  }
                  .onTapGesture {
                     isShowingMeaning.toggle()
                  }
                  .popover(isPresented: $isShowingMeaning, attachmentAnchor: .point(.bottom)) {
                     ZStack {
                        Color.customLightGray
                           .scaleEffect(1.5)
                        
                        Text(meaning)
                           .font(.hanzi())
                           .foregroundColor(.black)
                           .padding(.trailing)
                           .multilineTextAlignment(.leading)
                     }
                     .presentationCompactAdaptation(.popover)
                  }
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
   Speaker2BubbleChatView(hanzi: "Halo", pinyin: "Halo", meaning: "Halo")
      .background(.black)
}

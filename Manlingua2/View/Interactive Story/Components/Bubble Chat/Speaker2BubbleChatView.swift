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
   @State private var textWidth: CGFloat = 0
   
   var body: some View {
      VStack {
         HStack(alignment: .top, spacing: 4){
            Spacer()
            
            HStack(alignment: .top, spacing: 0) {
               VStack(spacing: 0) {
                  VStack(alignment: .leading, spacing: 2) {
                     Text(pinyin)
                        .font(.pinyin())
//                        .fontWeight(.bold)
                        .foregroundColor(.pinyinPhotoChallenge)
                     
                     // Chinese characters
                     Text(hanzi)
                        .font(.hanzi())
//                        .foregroundColor(.black)
                        .background(GeometryReader { geometry in
                           Color.clear.onAppear {
                              textWidth = max(textWidth, geometry.size.width)
                           }
                        })
                        .onTapGesture {
                           //                        withAnimation {
                           isShowingMeaning.toggle()
                           //                        }
                        }
                  }
                  .padding(8)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  
                  if isShowingMeaning {
                     VStack(alignment: .leading) {
                        CustomDivider(color: .white)
                        
                        Text(meaning)
                           .font(.system(size: 14))
                           .multilineTextAlignment(.leading)
                           .padding([.horizontal, .bottom], 8)
                     }
                     .frame(maxWidth: .infinity, alignment: .leading)
                  }
               }
               .background(
                  ZStack(alignment: .topLeading) {
                     RoundedRectangle(cornerRadius: 8)
                        .fill(.green1)
                  }
               )
               .fixedSize(horizontal: false, vertical: true)
               
               RightCustomTriangle(cornerRadius: 16)
                  .fill(.green1)
                  .frame(width: UIScreen.main.bounds.width * 0.035, height: UIScreen.main.bounds.height * 0.025)
                  .offset(x: -UIScreen.main.bounds.width * 0.004)
                  .padding(.top, UIScreen.main.bounds.height * 0.005)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(width: UIScreen.main.bounds.width * 0.6)
            
            Image(.orangeSpeaker2)
               .resizable()
               .scaledToFit()
               .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.06)
         }
      }
      .frame(maxHeight: UIScreen.main.bounds.height * 0.25)
   }
}

#Preview {
   Speaker2BubbleChatView(hanzi: "Halo", pinyin: "Halo", meaning: "Halo")
      .background(.white)
      .preferredColorScheme(.dark)
}

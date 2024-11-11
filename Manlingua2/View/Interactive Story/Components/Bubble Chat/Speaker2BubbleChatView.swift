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
      HStack{
         Spacer()
         
         HStack(alignment: .top, spacing: 0) {
            VStack(spacing: 8) {
               VStack(alignment: .leading, spacing: 2) {
                  Text(pinyin)
                     .font(.pinyin())
                     .fontWeight(.bold)
                     .foregroundColor(.gray)
                  
                  // Chinese characters
                  Text(hanzi)
                     .font(.hanzi())
                     .foregroundColor(.black)
                     .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                           textWidth = max(textWidth, geometry.size.width)
                        }
                     })
                     .overlay {
                        DottedUnderline()
                           .frame(height: UIScreen.main.bounds.height * 0.015)
                           .offset(y: UIScreen.main.bounds.height * 0.02)
                     }
                     .onTapGesture {
//                        withAnimation {
                           isShowingMeaning.toggle()
//                        }
                     }
               }
               .padding(8)
               //               .frame(maxWidth: .infinity, alignment: .leading)
               
               if isShowingMeaning {
                  VStack {
                     CustomDivider(color: .white)
                     
                     Text(meaning)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.trailing)
                        .padding([.trailing, .bottom], 8)
                  }
//                  .transition(.move(edge: .top).combined(with: .opacity))
               }
            }
            .background(
               ZStack(alignment: .topLeading) {
                  RoundedRectangle(cornerRadius: 8)
                     .fill(.green1)
               }
            )
            
            RightCustomTriangle(cornerRadius: 16)
               .fill(.green1)
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

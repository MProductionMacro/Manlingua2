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
   var meaning: String
   
   @State private var isShowingMeaning = false
   
   var body: some View {
      VStack {
         HStack(alignment: .top, spacing: 4) {
            Image(.orangeSpeaker1)  // Your custom image
               .resizable()
               .scaledToFit()
               .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.06)
            
            HStack(alignment: .top, spacing: 0) {
               LeftCustomTriangle(cornerRadius: 16)
                  .fill(.cardBackground)
                  .frame(width: UIScreen.main.bounds.width * 0.035, height: UIScreen.main.bounds.height * 0.025)
                  .offset(x: UIScreen.main.bounds.width * 0.004)
                  .padding(.top, UIScreen.main.bounds.height * 0.005)
               
               VStack(spacing: 0) {
                  VStack(alignment: .leading, spacing: 2) {
                     Text(pinyin)
                        .font(.pinyin())
//                        .fontWeight(.bold)
                        .foregroundColor(.pinyinPhotoChallenge)
                     
                     Text(hanzi)
                        .underline(pattern: .dot, color: .orange3)
                        .font(.hanzi())
                        .foregroundColor(.fontColors)
                        .onTapGesture {
                           isShowingMeaning.toggle()
                        }
                  }
                  .padding(8)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  
                  if isShowingMeaning {
                     VStack(alignment: .leading) {
                        CustomDivider(color: .primary)
                        
                        Text(meaning)
                           .font(.system(size: 14))
                           .multilineTextAlignment(.leading)
                           .padding([.horizontal, .bottom], 8)
                     }
                     .frame(maxWidth: .infinity, alignment: .leading)
                  }
               }
               .background(
                  RoundedRectangle(cornerRadius: 8)
                     .fill(.cardBackground)
               )
               .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(width: UIScreen.main.bounds.width * 0.6)
            
            Spacer()
         }
      }
      .frame(maxHeight: UIScreen.main.bounds.height * 0.25)
   }
}

struct DottedUnderline: View {
   var body: some View {
      GeometryReader { geometry in
         let totalWidth = geometry.size.width
         let overflowAmount: CGFloat = 0 // Extra space to make it overflow
         let circleDiameter: CGFloat = 3 // Diameter of each circle
         let spacing: CGFloat = 2 // Space between each circle
         let circleCount = Int((totalWidth + overflowAmount) / (circleDiameter + spacing)) // Increase the count with overflow
         
         HStack(spacing: spacing) {
            ForEach(0..<circleCount, id: \.self) { _ in
               Circle()
                  .fill(Color.orangeDarkMode)
                  .frame(width: circleDiameter, height: circleDiameter)
            }
         }
      }
   }
}

#Preview {
   Speaker1BubbleChatView(hanzi: "Halo", pinyin: "Halo", meaning: "Halo")
      .background(.black)
      .preferredColorScheme(.dark)
}

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
      HStack {
         Image(.orangeSpeaker1)  // Your custom image
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height * 0.08)
         
         HStack(alignment: .top, spacing: 0) {
            LeftCustomTriangle(cornerRadius: 16)
               .fill(.white)
               .frame(width: UIScreen.main.bounds.width * 0.04, height: UIScreen.main.bounds.height * 0.03)
               .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 2) {
               Text(pinyin)
                  .font(.pinyin())
                  .fontWeight(.bold)
                  .foregroundColor(.gray)
               
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
               RoundedRectangle(cornerRadius: 8)
                  .fill(.white)
            )
         }
         Spacer()
      }
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
                  .fill(Color.orange)
                  .frame(width: circleDiameter, height: circleDiameter)
            }
         }
      }
   }
}

#Preview {
   Speaker1BubbleChatView(hanzi: "Halo", pinyin: "Halo", meaning: "Halo")
      .background(.black)
}

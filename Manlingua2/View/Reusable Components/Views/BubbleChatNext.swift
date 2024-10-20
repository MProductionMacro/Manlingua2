//
//  BubbleChatNext.swift
//  HXD
//
//  Created by Michelle Angela Aryanto on 14/08/24.
//

import SwiftUI

struct BubbleChatNext: View {
   var text: String
   var bubbleColor: Color = .white
   var textColor: Color = .black
   var pos: String
   @ObservedObject var viewModel: StoryViewModel
   
   var body: some View {
      VStack(spacing: 0) {
         HStack {
            VStack (spacing: 0){
               Text(text)
               //TODO: Kalo mau 16 gausah kasih size lg karena padding default udah 16
                  .padding([.leading, .trailing, .top], 16)
                  .padding(.bottom, 7)
                  .foregroundColor(textColor)
                  .font(.title3)
                  .fontWeight(.semibold)
                  .frame(minWidth: 300, maxWidth: 300, alignment: .leading)
               HStack {
                  Spacer()
                  Button(action: {
                     //FIXME: Ini diganti jadi function yg seharusnya
//                     viewModel.moveToNextStage()
                  }) {
                     //TODO: Modifiernya kasih spacing
                     Text("Next").font(.title3).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundStyle(.orange3)
                  }
               }
               .padding(.top, 2)
               .padding(.bottom, 16)
               .padding(.horizontal, 16)
            }
         }
         .frame(minWidth: 300, maxWidth: 300, alignment: .leading)
         .background(bubbleColor)
         .clipShape(RoundedRectangle(cornerRadius: 16))
         .overlay(
            RoundedRectangle(cornerRadius: 16)
               .stroke(bubbleColor, lineWidth: 1)
         )
         BubbleChatTail(pos: "A")
            .fill(bubbleColor)
            .frame(width: 30, height: 15)
            .offset(y: -5)
      }
   }
}

//#Preview {
//    BubbleChatNext(text: "This isasdkjhflddddddddjhjhjfhkhdfkjashfjkashfjskhfkjahkjdhak", bubbleColor: .greenLight)
//}


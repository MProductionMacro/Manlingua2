//
//  PinyinNavigationButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct PinYinNavigationButtonView: View {
   @State var labelImage: ImageResource
   @State var title:String
   @State var content:String
   
   var body: some View {
      HStack() {
         HStack(spacing: 12) {
            Image(labelImage)
            VStack(alignment: .leading) {
               Text(title)
                  .font(.title3)
                  .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
               Text(content)
                  .multilineTextAlignment(.leading)
                  .font(.callout)
                  .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .foregroundStyle(Color(.black))
         Image(systemName: "chevron.right")
            .foregroundStyle(.orange3)
            .fontWeight(.bold)
         Spacer()
      }
      .frame(width: 320)
      .padding()
      .overlay(
         RoundedRectangle(cornerRadius: 20)
            .stroke(.customLightGray, lineWidth: 1)
      )
   }
}

#Preview {
   //    PinYinNavigationButton(labelImage: .initialIcon, title: "Initial", content: "Initials are usually consonants")
   //    PinYinNavigationButton(labelImage: .finalIcon, title: "Final", content: "Finals are usually made up of vowels")
   PinYinNavigationButtonView(labelImage: .toneIcon, title: "Tone", content: "Tones differentiate word meanings")
}

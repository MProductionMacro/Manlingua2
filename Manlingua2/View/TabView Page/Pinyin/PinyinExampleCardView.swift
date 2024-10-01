//
//  PinyinExampleCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct PinYinExampleCardView: View {
   var body: some View {
      // Syllable
      //TODO: Sizenya fixed
      VStack {
         HStack(alignment: .bottom) {
            VStack {
               HStack {
                  Image("initialN")
                  Image("finalI")
               }
               
               Text("Syllable")
                  .bold()
            }
            
            Spacer()
            
            VStack {
               Image("characterNI")
               
               Text("Character")
                  .bold()
            }
            //               .padding(.bottom, 40)
         }
      }
      .padding(.horizontal, 40)
      .padding(.vertical, 12)
      .background(.customLighterGray)
      .clipShape(RoundedRectangle(cornerRadius: 24))
   }
}

#Preview {
   PinYinExampleCardView()
}

//
//  BackButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 07/10/24.
//

import SwiftUI

struct BackButton: View {
   @Binding var isShowingConfirmation: Bool
   @Binding var isShowingDict: Bool
   
   var body: some View {
      Button(action: {
         if isShowingDict {
            isShowingDict = false
         } else {
            isShowingConfirmation = true
         }
      }) {
         Rectangle()
            .fill(Color.orange3)
            .frame(width: 50, height: 50)
            .overlay(
               Image(systemName: "arrowshape.backward.fill")
                  .foregroundStyle(.white)
                  .font(.system(size: 20))
            )
            .cornerRadius(10)
      }
   }
}

#Preview {
   BackButton(isShowingConfirmation: .constant(false), isShowingDict: .constant(false))
}

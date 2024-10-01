//
//  CardMenuButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct CardMenuButtonView: View {
   var isDisabled: Bool = false
   @ObservedObject var viewModel: StoryViewModel
   
   var body: some View {
      Button(action: {
         viewModel.recall = "recall"
      }) {
         Rectangle()
            .fill(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.gold2)
            .frame(width: 64, height: 64)
            .overlay(
               Image("menuIcon")
                  .resizable()
                  .renderingMode(.template)
                  .scaledToFit()
                  .frame(width: 32, height: 32)
                  .foregroundStyle(isDisabled ? Color(red: 0.7, green: 0.7, blue: 0.7) : Color.orange3)
            )
            .cornerRadius(10)
      }
      .disabled(isDisabled)
   }
   
}

#Preview {
   CardMenuButtonView(viewModel: StoryViewModel())
}

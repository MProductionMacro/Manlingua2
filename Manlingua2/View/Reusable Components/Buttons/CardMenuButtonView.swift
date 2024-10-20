//
//  CardMenuButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct CardMenuButtonView: View {
   var isDisabled: Bool = false
    var storyId: Int
   @EnvironmentObject var router: Router
   
   var body: some View {
      Button(action: {
          router.push(.journeyPage(storyId: storyId))
      }) {
         Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath.fill")
            .background(.white)
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3)
            .padding()
            .clipShape(
               RoundedRectangle(cornerRadius: 16)
            )
            .overlay(
               RoundedRectangle(cornerRadius: 16)
                  .stroke(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3, lineWidth: 2)
            )
      }
      .disabled(isDisabled)
   }
   
}

#Preview {
    CardMenuButtonView(storyId: 1)
      .environmentObject(Router())
}

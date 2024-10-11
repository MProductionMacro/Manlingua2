//
//  CardMenuButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct CardMenuButtonView: View {
   var isDisabled: Bool = false
   @EnvironmentObject var router: Router
   
   var body: some View {
      Button(action: {
         router.push(.journeyPage)
      }) {
         Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath.fill")
            .background(.white)
            .font(.system(size: 24))
            .foregroundStyle(.orange3)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .clipShape(
               RoundedRectangle(cornerRadius: 16)
            )
            .overlay(
               RoundedRectangle(cornerRadius: 16)
                  .stroke(.orange3, lineWidth: 2)
            )
      }
      .disabled(isDisabled)
   }
   
}

#Preview {
   CardMenuButtonView()
      .environmentObject(Router())
}

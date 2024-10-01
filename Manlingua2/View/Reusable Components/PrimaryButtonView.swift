//
//  PrimaryButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct PrimaryButtonView: View {
   @ObservedObject var homeViewModel: HomeViewModel
   @EnvironmentObject var router: Router
   var isDisabled: Bool = false
   
   var body: some View {
      Button(action: {
         router.push(.journeyPage)
      }){
         
         //         ZStack {
         //            //TODO: Hard coded size and color
         //            Rectangle()
         //               .foregroundColor(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3)
         //               .frame(width: 233, height: 64)
         //               .cornerRadius(12)
         Text("Practice")
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(isDisabled ? Color(red: 0.7, green: 0.7, blue: 0.7) : Color.white)
            .font(.system(size: 20, weight: .bold))
            .background(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3)
            .clipShape(.rect(cornerRadius: 12))
         
         //         }
      }
      .disabled(isDisabled)
   }
}

#Preview {
   PrimaryButtonView(homeViewModel: HomeViewModel())
      .environmentObject(Router())
}

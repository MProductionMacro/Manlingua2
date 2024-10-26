//
//  ConfirmationView.swift
//  HXD
//
//  Created by Ferdinand Jacques on 14/08/24.
//

import SwiftUI


struct ConfirmationView: View {
   @Binding var isShowingConfirmation: Bool
   @EnvironmentObject var router: Router
   
   var body: some View {
      ZStack {
         Rectangle()
            .frame(width: 313, height: 282)
            .foregroundColor(.white)
            .cornerRadius(16)
         
         VStack(alignment: .center, spacing: 16) {
            Text("Are you sure you want to leave this page?")
               .font(.system(size: 24, weight: .bold))
               .foregroundStyle(Color(.black))
               .multilineTextAlignment(.center)
            
            Text("You'll need to start the story over from the beginning")
               .font(.system(size: 16))
               .foregroundStyle(Color(.black))
               .multilineTextAlignment(.center)
            
            Button(action: {
               print("leave")
               isShowingConfirmation = false
               //                    homeVM.switchStage(to: .home)
            }) {
               Text("Leave")
            }
            .buttonStyle(PrimaryButton(isDisabled: false))
            
            Button(action: {
               print("back to story")
               isShowingConfirmation = false
            }) {
               ZStack{
                  Rectangle()
                     .frame(width: 265, height: 43)
                     .cornerRadius(16)
                     .foregroundColor(.white)
                  Text("Back to story")
                     .font(.system(size: 16))
                     .foregroundStyle(.orange3)
                     .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
               }
            }
         }
         .padding(.horizontal, 32)
         //            .shadow(radius: 16)
      }
   }
}

#Preview {
   ConfirmationView(isShowingConfirmation: .constant(true))
      .environmentObject(Router())
}

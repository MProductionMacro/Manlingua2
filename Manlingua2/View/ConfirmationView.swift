//
//  ConfirmationView.swift
//  HXD
//
//  Created by Ferdinand Jacques on 14/08/24.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var isShowingConfirmation: Bool
    @ObservedObject var homeVM: HomeViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 313, height: 282)
                .foregroundColor(.white)
                .cornerRadius(16)
            VStack(alignment: .center) {
                Text("Are you sure you want")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(.black))
                Text("to leave this page?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color(.black))
                    .padding(.bottom, 15)
                Text("You'll need to start the story over")
                    .font(.system(size: 16))
                    .foregroundStyle(Color(.black))
                Text("from the beginning")
                    .font(.system(size: 16))
                    .padding(.bottom, 15)
                    .foregroundStyle(Color(.black))
                Button(action: {
                    print("leave")
                    isShowingConfirmation = false
                    homeVM.switchStage(to: .home)
                }) {
                    ZStack{
                        Rectangle()
                            .frame(width: 265, height: 43)
                            .cornerRadius(16)
                            .foregroundColor(.orange3)
                        Text("Leave")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                }
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
//            .shadow(radius: 16)
        }
    }
}

#Preview {
    ConfirmationView(isShowingConfirmation: .constant(true), homeVM: HomeViewModel())
}

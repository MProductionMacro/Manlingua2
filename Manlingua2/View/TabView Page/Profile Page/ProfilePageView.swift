//
//  ProfilePageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 15/10/24.
//

import SwiftUI

struct ProfilePageView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var router: Router
    var body: some View {
        VStack(alignment: .center){
            HStack{
                Image("ProfilePicture")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 5)
                VStack(alignment: .leading){
                    Text("\(viewModel.getName())")
                        .font(Font.titleKe2())
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    Text("\(viewModel.getLevel())")
                        .font(Font.subJudul())
                        .padding(.top, 1)
                        .foregroundColor(.darkGrey2)
                }
                Spacer()
            }
            .frame(width: 361)
            .padding(.bottom, 17)
            .padding(.top, 30)
         
            VStack(spacing: 32){
                VStack(spacing: 24){
                    ProfileNavigationButton(title: "Languages", imageName: "globe"){
                        router.push(.languageSetting)
                    }
                    .frame(width: 361, height: 35)
               
               
                    ProfileNavigationButton(title: "Notification", imageName: "bell"){
                        router.push(.notificationSetting)
                    }
                    .frame(width: 361, height: 35)
               
                    ProfileNavigationButton(title: "IoT", imageName: "externaldrive.connected.to.line.below"){
                  
                    }
                    .frame(width: 361, height: 35)
                }
                .frame(width: 393)
                .padding(.top, 24)
            
                Spacer()
            }
            .frame(width: 401, height: 621)
            .background(.white)
            .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
         
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Image("ProfilePage"))
    }
}

#Preview {
   ProfilePageView()
      .environmentObject(Router())
}

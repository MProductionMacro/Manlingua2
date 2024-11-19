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
                        .foregroundColor(.userRank)
                }
                Spacer()
            }
            .frame(width: 361)
            .padding(.bottom, 17)
            .padding(.top, 30)
         
            VStack(spacing: 32){
                VStack(spacing: 24){
                    ProfileNavigationButton(title: "Bahasa", imageName: "globe"){
                        router.push(.languageSetting)
                    }
                    .frame(width: 361, height: 35)
               
               
                    ProfileNavigationButton(title: "Notifikasi", imageName: "bell"){
                        router.push(.notificationSetting)
                    }
                    .frame(width: 361, height: 35)
               
                    ProfileNavigationButton(title: "Perangkat Pintar", imageName: "externaldrive.connected.to.line.below"){
                        router.push(.ioTSetting)
                    }
                    .frame(width: 361, height: 35)
                }
                .frame(width: 393)
                .padding(.top, 24)
            
                Spacer()
                
                HStack{
                    Image(systemName: "door.left.hand.open")
                        .foregroundStyle(.orangeDarkMode)
                        .font(.semibold16())
                        .padding(.trailing, 10)

                    /*
                        .resizable()
                        .foregroundStyle(.orange)
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 10)
                    */
                    Text("Log Out")
                        .font(Font.semibold16())
                        .foregroundColor(.profileNavigationText)
                    Spacer()
                }
                .frame(width: 361, height: 35)
                .padding(.bottom, 80)
            }
            .frame(width: 401, height: 671)
            .background(.blankBackground)
            .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
         
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Image(.profilePage)
            .ignoresSafeArea()
            .scaledToFill()
        )
    }
}

#Preview {
   ProfilePageView()
      .environmentObject(Router())
}

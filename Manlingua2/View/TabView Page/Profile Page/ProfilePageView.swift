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
        ZStack{
            Image("ProfilePage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack(alignment: .center){
                //Spacer()
                
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
                .frame(width: 361 * (UIScreen.main.bounds.width/393))
                .padding(.top, 50)

                //.padding(.bottom, 17)

                /*
                .padding(.bottom, 17)
                .padding(.top, 30)
                */
                //Spacer()
                
                VStack(spacing: 32){
                    VStack(spacing: 24){
                        ProfileNavigationButton(title: "Languages", imageName: "globe"){
                            router.push(.languageSetting)
                        }
                        .frame(width: 361 * (UIScreen.main.bounds.width/393), height: 35)
                        
                        ProfileNavigationButton(title: "Notification", imageName: "bell"){
                            router.push(.notificationSetting)
                        }
                        .frame(width: 361 * (UIScreen.main.bounds.width/393), height: 35)

                        ProfileNavigationButton(title: "IoT", imageName: "externaldrive.connected.to.line.below"){
                            router.push(.ioTSetting)
                        }
                        .frame(width: 361 * (UIScreen.main.bounds.width/393), height: 35)
                    }
                    .frame(width: 393)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "door.left.hand.open")
                            .resizable()
                            .foregroundStyle(.orange)
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        
                        Text("Log Out")
                            .font(Font.judulBiasa())
                            .foregroundColor(.profileNavigationText)
                        Spacer()
                    }
                    .frame(width: 361, height: 35)
                    .padding(.bottom, 24)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.75)
                .background(.blankBackground)
                .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        //.edgesIgnoringSafeArea(.bottom)
        /*
        .background(
            Image("ProfilePage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
         */
    }
}

#Preview {
   ProfilePageView()
      .environmentObject(Router())
}

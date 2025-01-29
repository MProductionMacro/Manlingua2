//
//  NotificationSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/11/24.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct ProfilePageView: View {
   @StateObject private var viewModel = ProfileViewModel()
   @StateObject private var singleton = SwiftDataServices.shared
   @EnvironmentObject private var router: Router
    //@EnvironmentObject var swiftDataServices: SwiftDataServices
    //@State private var avatarImage: Image = SwiftDataServices.shared.profilePicture
   @StateObject private var swiftDataServices = SwiftDataServices.shared
   @State private var photosPickerItem: PhotosPickerItem?
   private var userRank = UserRank.allCases
   
   var body: some View {
      ZStack{
         VStack(alignment: .center, spacing: 0) {
            HStack{
                ZStack(alignment: .bottomTrailing){
                    swiftDataServices.profilePicture
                       .resizable()
                       .frame(width: 63, height: 63)
                       .cornerRadius(180)
                       .padding(.trailing, 5)
                       .onTapGesture{
                           withAnimation{
                               //viewModel.isShowProfilePict.toggle()
                           }
                       }
                    
                    PhotosPicker(selection: $photosPickerItem, matching: .images){
                        Image(systemName: "plus")
                            .font(.bold12())
                            .foregroundStyle(.orangeDarkMode)
                            .frame(width: 20, height: 20)
                            .background(.cardBackground)
                            .cornerRadius(180)
                            .shadow(color: .cardShadow.opacity(0.15), radius: 5, x: 0, y: 0)
                            .padding(.trailing, 2)
                            .padding(.bottom, 2)
                            //.frame(width: 30, height: 30)
                    }
                    .onChange(of: photosPickerItem) { oldItem, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                print("Tahap Pertama")
                                swiftDataServices.profilePicture = Image(uiImage: uiImage)
                            }
                            
                            if let photo = newItem {
                                print("Tahap Kedua")
                                SwiftDataServices.shared.updateProfilePicture(photo: photo)
                            }
                        }


                    }
                }

               VStack(alignment: .leading){
                   HStack(alignment: .center){
                       Text("\(swiftDataServices.username)")
                          .font(Font.titleKe2())
                          .foregroundColor(.white)
                       
                       Button(action:{
                           router.push(.changeName)
                       },label:{
                           Image(systemName: "pencil.line")
                               .font(Font.bold20())
                               .foregroundColor(.white)
                       })
                   }
                   .padding(.bottom, 1)

                   Text(viewModel.getLevel().localized)
                     .font(Font.subJudul())
                     .padding(.horizontal)
                     .padding(.vertical, 8)
//                     .frame(width: 92, height: 35)
                     .foregroundColor(UserRankStyle.getTextColor(userRank[swiftDataServices.rank]))
                     .background(UserRankStyle.getBackgroundColor(userRank[swiftDataServices.rank]))
//                     .padding()
                     .cornerRadius(8)
               }
               Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical)
            //.padding(.bottom, 17)
            
            VStack(spacing: 24) {
               ProfileNavigationButton(title: "Bahasa".localized, imageName: "globe"){
                  router.push(.languageSetting)
               }
               .frame(maxWidth: .infinity)
               .padding(.horizontal, 20)
               .frame(height: 35)
               .padding(.top, 24)
               
               
               ProfileNavigationButton(title: "Notification".localized, imageName: "bell"){
                  router.push(.notificationSetting)
               }
               .frame(height: 35)
               .frame(maxWidth: .infinity)
               .padding(.horizontal, 20)
               /*
               ProfileNavigationButton(title: "Perangkat Pintar".localized, imageName: "externaldrive.connected.to.line.below"){
                  //router.push(.ioTSetting)
                   router.push(.ioTSetting)
                   print(SwiftDataServices.shared.getProfilePicture())

               }
               .frame(height: 35)
               .frame(maxWidth: .infinity)
               .padding(.horizontal, 20)
               */
               Spacer()
                
//               HStack{
//                   Image(systemName: "door.left.hand.open")
//                      .foregroundStyle(.orangeDarkMode)
//                      .font(.semibold16())
//                      .padding(.trailing, 10)
//
//
//                   Text("Log Out".localized)
//                      .font(Font.semibold16())
//                      .foregroundColor(.profileNavigationText)
//                   Spacer()
//               }
//               .frame(height: 35)
//               .frame(maxWidth: .infinity)
//               .padding(.horizontal, 20)
//               .padding(.bottom, 124)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blankBackground)
            .cornerRadius(32, corners: [.topLeft, .topRight])
         }
         .padding(.top)
         .ignoresSafeArea(edges: .bottom)
      }
      .overlay{
          /*
          if viewModel.isShowProfilePict{
              ZStack{
                  swiftDataServices.profilePicture
                      .resizable()
                      .frame(width: 300, height: 300)
                      .cornerRadius(180)
              }
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .safeAreaPadding(.bottom)
              .background(.black.opacity(0.7))
              .onTapGesture{
                  withAnimation(.easeInOut(duration: 0.2)) {
                      viewModel.isShowProfilePict.toggle()
                  }
              }
          }
           */
      }
      .edgesIgnoringSafeArea(.bottom)
      .background(
         Image("ProfilePage")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
      )
   }
}

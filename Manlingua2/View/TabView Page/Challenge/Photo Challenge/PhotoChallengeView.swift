//
//  GoalView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct PhotoChallengeView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   @StateObject var camera = CameraController.shared
   @State var isCorrect = false
   
   @State var isShowingCamera = false
   
   var body: some View {
      VStack(alignment: .leading){
          Text("Tantangan Foto".localized)
            .font(.judulBesar())
            .foregroundStyle(.white)
            .padding()
         
         if camera.hasCameraPermission {
            CameraGrantedView()
         }else{
            CameraNotGrantedView(primaryButtonPressed: {
               camera.checkPermission()
            }, secondaryButtonPressed: {
               router.pop()
            })
         }
         
//         CameraGrantedView()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .edgesIgnoringSafeArea(.bottom)
      .background(
         Image(.profilePage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
      )
      .padding(.top, UIScreen.main.bounds.height < 700 ? -40 : 8)
      .overlay {
         
      }
      .onAppear(perform: {
         viewModel.fetchObjects()
      })
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            HStack(alignment: .top) {
               Button(action: {
                  router.popToRoot()
               }) {
                  Image(systemName: "chevron.left")
                     .foregroundColor(.white)
                     .font(.semibold16())
                  
                   Text("Kembali".localized)
                     .foregroundColor(.white)
                     .font(.semibold20())
               }
            }
         }
      }
   }
}

#Preview {
   NavigationStack {
      PhotoChallengeView()
         .environmentObject(Router())
         .environmentObject(ChallengeViewModel())
   }
}

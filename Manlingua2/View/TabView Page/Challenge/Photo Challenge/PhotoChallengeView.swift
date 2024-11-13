//
//  GoalView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct PhotoChallengeView: View {
   @EnvironmentObject var router: Router
//   @StateObject var viewModel = ChallengeViewModel()
   @StateObject var camera = CameraController.shared
   @State var isCorrect = false
   
   var body: some View {
      VStack(alignment: .leading){
         Text("Tantangan Foto")
            .font(.judulBesar())
            .foregroundStyle(.white)
            .padding()
         
         if camera.hasCameraPermission {
            CameraGrantedView()
         }else{
            CameraNotGrantedView(primaryButtonPressed: {
               camera.requestPermission()
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
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            HStack(alignment: .top) {
               Button(action: {
                  router.pop()
               }) {
                  Image(systemName: "chevron.left")
                     .foregroundColor(.white)
                     .font(.title3)
                     .bold()
                  
                  Text("Kembali")
                     .foregroundColor(.white)
                     .bold()
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

//
//  CameraGrantedView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI

struct CameraGrantedView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   @StateObject var cameraController = CameraController.shared
   
   @State var image: UIImage = UIImage(resource: .placeholderChallenge)
   
   var body: some View {
      ScrollView {
         VStack(spacing: 24){
            VStack(alignment: .leading) {
               Text("Cari dan fotokan")
                  .font(.judulBiasa())
               
               Text("pinyin")
                  .font(.pinyin())
                  .foregroundStyle(.gray)
               
               Text("hanzi")
                  .font(.hanzi())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 32)
            
            VStack {
               if let capturedImage = cameraController.capturedImage {
                  Image(uiImage: capturedImage)
                     .resizable()
                     .scaledToFit()
                     .padding()
               } else {
                  Image(.placeholderChallenge)
               }
               
               //            Image(uiImage: image)
               
               Button {
                  router.push(.cameraView)
               } label: {
                  Image(systemName: "camera.fill")
                     .font(.system(size: 32))
                     .padding(8)
               }
               .buttonStyle(CircleButton())
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
            .background(.customLighterGray)
            .clipShape(.rect(cornerRadius: 35))
            .overlay(
               RoundedRectangle(cornerRadius: 36)
                  .stroke(Color.gray, lineWidth: 2)
            )
            
            Button {
               
            } label: {
               Text("Lewati")
                  .frame(maxWidth: .infinity)
            }
            .buttonStyle(SecondaryButton(isDisabled: false))
            
            ForEach(viewModel.predictions, id: \.self) { prediction in
               Text("\(prediction.class) : \(prediction.confidence)")
            }
            
//            Spacer()
         }
      }
      .padding(.horizontal)
      .padding(.top, 32)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
      .ignoresSafeArea()
   }
}

#Preview {
   CameraGrantedView()
      .environmentObject(Router())
      .environmentObject(ChallengeViewModel())
}

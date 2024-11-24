//
//  CameraTestView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
   @EnvironmentObject var viewModel: ChallengeViewModel
   @StateObject private var cameraController = CameraController.shared
   @Binding var isShowingCamera: Bool
   @Binding var isLoading: Bool
   
   var body: some View {
      ZStack {
         if cameraController.isCameraActive, let session = cameraController.captureSession {
            CameraPreview(captureSession: session)
               .edgesIgnoringSafeArea(.all)
         }
         
         VStack {
            Spacer()
            
            Button {
               cameraController.capturePhoto()
               
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                  isShowingCamera = false
                  isLoading = true // Set loading state true
               }
               
               cameraController.onCaptureComplete = { image in
                  viewModel.predictImage(image) // Perform the prediction
               }
            } label: {
               Circle()
                  .fill(Color.white)
                  .frame(width: 70, height: 70)
                  .overlay(Circle().stroke(Color.gray, lineWidth: 3))
            }
            .padding(.bottom)
         }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
         cameraController.startSession()
      }
      .onDisappear {
         cameraController.stopSession()
      }
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            Button {
               isShowingCamera = false
            } label: {
               HStack {
                  Image(systemName: "chevron.left")
                     .font(.title3)
                     .bold()
                  Text("Kembali".localized)
                     .bold()
               }
               .foregroundStyle(.white)
            }
         }
      }
      .background(Color.black)
   }
}




//#Preview {
//   NavigationStack {
//      CameraView()
//   }
//   .environmentObject(Router())
//   .environmentObject(ChallengeViewModel())
//}

//
//  CameraTestView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   
   @StateObject private var cameraController = CameraController.shared
   
   var body: some View {
      ZStack {
         if cameraController.isCameraActive, let session = cameraController.captureSession {
            CameraPreview(captureSession: session)
               .edgesIgnoringSafeArea(.all)
         }
         
         VStack {
            Spacer()
            
            Button(action: {
               cameraController.capturePhoto()
               //               router.pop()
            }) {
               Circle()
                  .fill(Color.white)
                  .frame(width: 70, height: 70)
                  .overlay(
                     Circle()
                        .stroke(Color.gray, lineWidth: 3)
                  )
            }
            .padding(.bottom)
         }
         
         //         if let capturedImage = cameraController.capturedImage {
         //            Color.black.opacity(0.6)
         //               .edgesIgnoringSafeArea(.all)
         //
         //            Image(uiImage: capturedImage)
         //               .resizable()
         //               .scaledToFit()
         //               .padding()
         //
         //            VStack {
         //               Spacer()
         //               Button(action: {
         //                  cameraController.capturedImage = nil
         //               }) {
         //                  Text("Dismiss")
         //                     .padding()
         //                     .background(Color.white)
         //                     .cornerRadius(10)
         //               }
         //               .padding(.bottom)
         //            }
         //         }
      }
      .onAppear {
         cameraController.startSession()
         cameraController.onCaptureComplete = { image in
            cameraController.capturedImage = image // Update captured image to display
            viewModel.predictImage(image)
            router.pop() // Navigate back to CameraGrantedView
         }
      }
      .onDisappear {
         cameraController.stopSession()
      }
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            Button {
               router.pop()
            } label: {
               HStack{
                  Image(systemName: "chevron.left")
                     .font(.title3)
                     .bold()
                  
                  Text("Kembali")
                     .bold()
               }
               .foregroundStyle(.white)
            }
         }
      }
      .frame(maxWidth: .infinity)
      .background(.black)
   }
}

#Preview {
   NavigationStack {
      CameraView()
   }
   .environmentObject(Router())
   .environmentObject(ChallengeViewModel())
}

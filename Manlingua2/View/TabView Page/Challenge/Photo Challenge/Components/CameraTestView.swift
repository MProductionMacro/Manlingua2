//
//  CameraTestView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI
import AVFoundation

struct CameraTestView: View {
   @StateObject private var cameraController = CameraController()
   
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
         
         if let capturedImage = cameraController.capturedImage {
            Color.black.opacity(0.6)
               .edgesIgnoringSafeArea(.all)
            
            Image(uiImage: capturedImage)
               .resizable()
               .scaledToFit()
               .padding()
            
            VStack {
               Spacer()
               Button(action: {
                  cameraController.capturedImage = nil
               }) {
                  Text("Dismiss")
                     .padding()
                     .background(Color.white)
                     .cornerRadius(10)
               }
               .padding(.bottom)
            }
         }
      }
      .onAppear {
         cameraController.startSession()
      }
      .onDisappear {
         cameraController.stopSession()
      }
   }
}

#Preview {
   CameraTestView()
}

//
//  CameraNotGrantedView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI

struct CameraNotGrantedView: View {
   var primaryButtonPressed: () -> Void
   var secondaryButtonPressed: () -> Void
   
   var body: some View {
      ZStack {
         VStack(spacing: 24) {
            VStack(spacing: 16) {
               Image(systemName: "camera")
                  .font(.largeTitle)
                  .padding(UIScreen.main.bounds.width * 0.08)
                  .background(
                     Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                  )
               
                Text("Izinkan Akses Kamera".localized)
                  .font(.judulBiasa())
               
                Text("Untuk mengerjakan tantangan, kami memerlukan kameramu untuk mendeteksi foto".localized)
                  .multilineTextAlignment(.center)
                  .font(.normalText())
                  .frame(width: UIScreen.main.bounds.width * 0.7)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Rectangle()
               .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10])))
            
            VStack {
               Button {
                  primaryButtonPressed()
               } label: {
                   Text("Berikan Izin Akses Kamera".localized)
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(PrimaryButton(isDisabled: false))
               
               Button {
                  secondaryButtonPressed()
               } label: {
                   Text("Batalkan".localized)
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
            }
         }
         .padding(.vertical, UIScreen.main.bounds.height * 0.08)
         .padding(.horizontal)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
      .ignoresSafeArea()
   }
}

#Preview {
   CameraNotGrantedView(primaryButtonPressed: {}, secondaryButtonPressed: {})
}

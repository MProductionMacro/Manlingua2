//
//  GoalView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct PhotoChallengeView: View {
   @EnvironmentObject var router: Router
   
   var body: some View {
      VStack(alignment: .leading){
         Text("Tantangan Foto")
            .font(.judulBesar())
            .foregroundStyle(.white)
            .padding()
         
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
                  
                  Text("Izinkan Akses Kamera")
                     .font(.judulBiasa())
                  
                  Text("Untuk mengerjakan tantangan, kami memerlukan kameramu untuk mendeteksi foto")
                     .multilineTextAlignment(.center)
                     .font(.normalText())
                     .frame(width: UIScreen.main.bounds.width * 0.7)
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
//               .padding(.vertical, UIScreen.main.bounds.height * 0.12)
               .background(Rectangle()
                  .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10])))
               
               VStack {
                  Button {
                     
                  } label: {
                     Text("Berikan Izin Akses Kamera")
                  }
                  .buttonStyle(PrimaryButton(isDisabled: false))
                  
                  Button {
                     
                  } label: {
                     Text("Batalkan")
                        .frame(maxWidth: .infinity)
                  }
                  .buttonStyle(SecondaryButton(isDisabled: false))
               }
//               Spacer()
            }
            .padding(.vertical, UIScreen.main.bounds.height * 0.08)
            .padding(.horizontal)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(.white)
         .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
         .ignoresSafeArea()
         
         Spacer()
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .edgesIgnoringSafeArea(.bottom)
      .background(
         Image(.homeBackground)
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
   }
}

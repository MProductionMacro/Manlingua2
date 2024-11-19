//
//  PinyinMenuView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//
import SwiftUI

struct PinyinPageView: View {
   @EnvironmentObject var router: Router

   var body: some View {
      VStack(spacing: 32) {
          
          Text("Pelajari Pin Yin".localized)
            .font(Font.judulBesar())
            .foregroundStyle(.white)
            .padding(.top, 40)//0
         
         PinYinCardView()
            .padding(.horizontal)
            .environmentObject(router)
         
         VStack(spacing: 16) {
             PinYinNavigationButton(labelImage: .inisialLogo, title: "Inisial", content: "Huruf awal berupa konsonan"){
               router.push(.pinyinInisial)
            }
            
             PinYinNavigationButton(labelImage: .finalLogo, title: "Final", content: "Huruf akhir terdiri dari vokal"){
               router.push(.pinyinFinal)
            }
            
             PinYinNavigationButton(labelImage: .nadaLogo, title: "Nada", content: "Nada mengubah arti kata"){
               router.push(.pinyinNada)
            }
         }
         Spacer()
      }
      .background(
        Image(.pinyinBackground)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
      )
      // Nanti Ganti Background
   }

   // Fungsi untuk refresh atau reload data di PinYinCardView
   private func refreshPinYinData() {
       // Contoh refresh data di PinYinCardView
       // Anda bisa menambahkan logika untuk memuat ulang data
       print("Refreshing PinYinCardView data")
   }
}

#Preview {
   PinyinPageView()
      .environmentObject(Router())
}

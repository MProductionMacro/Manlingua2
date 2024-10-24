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
            Text("Pelajari Pin Yin")
                .fontWeight(.heavy)
                .font(.system(size: 48))
                .foregroundStyle(.white)
                .padding(.top)
         
            
            PinYinExampleCardView2()
                .padding(.horizontal)
         
            VStack(spacing: 16) {
                PinYinNavigationButton(labelImage: .inisialLogoNew, title: "Inisial", content: "Huruf awal berupa konsonan"){
                    router.push(.pinyinInisial)
                }

                PinYinNavigationButton(labelImage: .finalLogoNew, title: "Final", content: "Huruf akhir terdiri dari vokal"){
                    router.push(.pinyinFinal)
                }

                PinYinNavigationButton(labelImage: .nadaLogoNew, title: "Nada", content: "Nada mengubah arti kata"){
                    router.push(.pinyinNada)
                }
            }
            Spacer()
        }
        .background(Image(.pinyinBackground).resizable().scaledToFill())
        // Nanti Ganti Background
    }
}

#Preview {
    PinyinPageView()
        .environmentObject(Router())
}

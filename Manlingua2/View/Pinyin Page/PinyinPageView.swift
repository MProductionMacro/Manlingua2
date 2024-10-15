//
//  PinyinMenuView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import SwiftUI

struct PinyinPageView: View {
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
                PinYinNavigationButton(labelImage: .initialIcon, title: "Inisial", content: "Huruf awal berupa konsonan"){
                    withAnimation{
                        print("Inisial")
                    }
                }

                PinYinNavigationButton(labelImage: .finalIcon, title: "Final", content: "Huruf akhir terdiri dari vokal"){
                    withAnimation{
                        print("Final")
                    }
                }

                PinYinNavigationButton(labelImage: .toneIcon, title: "Nada", content: "Nada mengubah arti kata"){
                    withAnimation{
                        print("Nada")
                    }
                }
            }
            Spacer()
        }
        .background(Image(.pinyinBackground))
        // Nanti Ganti Background
    }
}

#Preview {
    PinyinPageView()
}

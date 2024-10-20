//
//  PinYinExampleCardView2.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//
import SwiftUI

struct PinYinExampleCardView2: View {
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                VStack {
                    HStack (alignment: .bottom){
                        Image("InisialNew")
                        Image("FinalNadaNew")
                    }
               
                    Text("Suku Kata")
                        .bold()
                }
                .padding(.leading, 5)
                Spacer()
            
                VStack {
                    Image("KarakterNew")
                        .padding(.bottom, 36)
                    Text("Karakter")
                        .bold()
                }
                .padding(.trailing, 5)

            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 12)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview{
    PinYinExampleCardView2()
}

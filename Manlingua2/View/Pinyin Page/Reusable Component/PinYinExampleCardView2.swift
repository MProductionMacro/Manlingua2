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
                    HStack {
                        Image("initialN")
                        Image("finalI")
                    }
               
                    Text("Suku Karakter")
                        .bold()
                }
            
                Spacer()
            
                VStack {
                    Image("characterNI")
                    Text("Karakter")
                        .bold()
                }
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

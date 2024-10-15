//
//  PinYinNavigationButtonView2.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//
import SwiftUI

struct PinYinNavigationButton: View {
    @State var labelImage: ImageResource
    @State var title:String
    @State var content:String
    let action: () -> Void 

    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                HStack(spacing: 12) {
                    Image(labelImage)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(content)
                            .multilineTextAlignment(.leading)
                            .font(.callout)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(.black))

                Image(systemName: "chevron.right")
                    .foregroundStyle(.orange3)
                    .fontWeight(.bold)
                    .frame(width: 24, height: 24)
            }
            .frame(width: 320)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.customLightGray, lineWidth: 1)
            )
        })
    }
}



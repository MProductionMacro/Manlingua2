//
//  ProfileNavigationButton.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 15/10/24.
//

import SwiftUI


struct ProfileNavigationButton: View {
    
    var title: String
    var imageName: String
    var action: () -> Void // Fungsi sebagai parameter

    
    var body: some View{
        Button(action:{
            action()
        }, label: {
            HStack{
                Image(systemName: "\(imageName)")
                    .resizable()
                    .foregroundStyle(.orange)
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
                Text("\(title)")
                    .font(Font.judulBiasa())
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.orange)
            }
        })

    }
}

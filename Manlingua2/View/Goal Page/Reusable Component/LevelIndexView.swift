//
//  LevelIndexView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct LevelIndexView : View {
    var body : some View {
        ZStack {
            HStack{
                
            }
            .frame(width: 355, height: 4)
            .background(.blue)
            .opacity(0.7)
            .cornerRadius(10)
            
            HStack{
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.greenDarkHover)
                    .padding(.leading, 11)
                
                Spacer()
                
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(.greenNormalActive)
                
                Spacer()
                
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.green2)
                
                Spacer()
                
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(.greenNormalActive)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.greenDarkHover)
                    .padding(.trailing, 11)
                
            }
            .frame(width: 355, height: 20)

        }
        .frame(width: 355, height: 20)
    }
}

#Preview{
    LevelIndexView()
}

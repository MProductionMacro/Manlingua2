//
//  DetailIoTRowView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 12/11/24.
//

import SwiftUI

struct DetailIoTRowView : View {
    
    var label: String
    var value: String
    var isEditable: Bool = false
    @State private var editText: String = ""
    
    var body : some View{
        if isEditable {
            VStack(alignment: .leading, spacing: 8){
                Text("\(label)")
                    .font(Font.normal16())
                    .foregroundStyle(.fontColors)
                    .opacity(0.65)

                ZStack(alignment: .center){
                    TextField("\(value)", text: $editText)
                        .font(Font.normal16())
                        .foregroundStyle(.fontColors)
                        .frame(width: 325)
                        .padding(.leading, 16)
                    
                    
                    Image(systemName: "pencil.line")
                        .foregroundStyle(.fontColors)
                        .frame(width: 325, alignment: .trailing)
                        .padding(.leading, 16)

                }
                .frame(width: 357, height: 44, alignment: .leading)
                .background(.detailIoTSelectedContainer)
                //.background(.detailIoTSelectedContainer)
                .cornerRadius(10)
                .shadow(color: .cardShadow.opacity(0.15), radius: 5, x: 0, y: 0)

            }
            .onAppear{
                editText = value
            }
        }
        else{
            VStack(alignment: .leading, spacing: 8){
                Text("\(label)")
                    .font(Font.normal16())
                    .foregroundStyle(.fontColors)
                    .opacity(0.65)

                HStack{
                    Text("\(value)")
                        .font(Font.normal16())
                        .foregroundStyle(.detailIoTText)
                        .padding(.leading, 16)
                }
                .frame(width: 357, height: 44, alignment: .leading)
                .background(.detailIoTContainer)
                .cornerRadius(10)
            }
        }
    }
}

//
//  RectangleButton.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//
import SwiftUI

struct RectangleButton: View {
    @EnvironmentObject var router: Router
    @State var labelImage:ImageResource?
    @State var label:String
    @State var backgroundColor:Color
    @State var buttonSize: ButtonSize
    @State var fontSytle: Font
    let action: () -> Void

    var body: some View {
        
        Button(action: {
            action()
        }) {
            HStack{
                if let image = labelImage {
                    Image(image)
                }
                Text(label)
                    .font(fontSytle)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange3)
            }.frame(width: buttonSize.size.width,height: buttonSize.size.height)
                .background(backgroundColor)
                .clipShape(.rect(cornerRadius: 12))
        }
        
        
        
    }
}

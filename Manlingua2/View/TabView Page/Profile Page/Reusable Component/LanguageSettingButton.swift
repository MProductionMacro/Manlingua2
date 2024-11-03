//
//  LanguageSettingButton.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct LanguageSettingButton : View {
    
    var image: ImageResource
    var text: String
    var selectionId: Int
    @Binding var selectedId: Int
    var action : () -> Void
    
    var body : some View {
        Button(action: {
            action()
        }) {
            HStack{
                Image(image)
                    .padding(.leading, 8)
                Text(text)
                    .foregroundStyle(selectedId == selectionId ? .orange3 : .black)
                    .font(.normal16())
                Spacer()
            }
               .frame(maxWidth: .infinity)
               .frame(height: 50)
               .background(.white)
               .clipShape(.rect(cornerRadius: 8))
               .cornerRadius(8)
               .overlay {
                   if selectedId == selectionId {
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(.orange3, lineWidth: 1)
                   }
               }
               .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 0)

        }
    }
}

#Preview{
    LanguageSettingButton(image: .indonesianLogo, text: "Bahasa Indonesia", selectionId: 1, selectedId: .constant(1)){
    }
}

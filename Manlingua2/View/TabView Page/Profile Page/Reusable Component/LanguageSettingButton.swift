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
                    .foregroundStyle(selectedId == selectionId ? .orangeDarkMode : .fontColors)
                    .font(.normal16())
                Spacer()
            }
               .frame(maxWidth: .infinity)
               .frame(height: 50)
               .background(.blankBackground)
               .clipShape(.rect(cornerRadius: 8))
               .cornerRadius(8)
               .overlay {
                   if selectedId == selectionId {
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(.orangeDarkMode, lineWidth: 1)
                   }
                   else{
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(.white, lineWidth: 1)
                   }
               }
               .shadow(color: .cardShadow.opacity(0.15), radius: 5, x: 0, y: 0)

        }
    }
}

#Preview{
    LanguageSettingButton(image: .indonesianLogo, text: "Bahasa Indonesia", selectionId: 1, selectedId: .constant(1)){
    }
}

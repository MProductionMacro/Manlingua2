//
//  AnswerButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 17/10/24.
//

import SwiftUI

struct AnswerButton: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding()
         .frame(maxWidth: .infinity)
         .foregroundStyle(.black)
         .clipShape(.rect(cornerRadius: 12))
         .overlay {
            RoundedRectangle(cornerRadius: 12)
               .stroke(.orange1, lineWidth: 1)
         }
   }
}

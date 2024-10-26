//
//  JourneyPageButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 25/10/24.
//

import SwiftUI

struct JourneyPageButton: ButtonStyle {
   func makeBody(configuration: Configuration) -> some View {
      configuration.label
         .padding()
         .foregroundColor(.orange)
         .background(.gold2)
         .clipShape(.rect(cornerRadius: 12))
   }
}

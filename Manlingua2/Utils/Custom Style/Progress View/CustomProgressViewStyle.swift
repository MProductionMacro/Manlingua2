//
//  CustomProgressViewStyle.swift
//  Manlingua2
//
//  Created by Paulus Michael on 09/10/24.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
   var height: CGFloat
   var filledColor: Color
   var unfilledColor: Color
   
   func makeBody(configuration: Configuration) -> some View {
      GeometryReader { geometry in
         ZStack(alignment: .leading) {
            // Unfilled part (background)
            Rectangle()
               .frame(height: height)
               .foregroundColor(unfilledColor)
            
            // Filled part (progress)
            Rectangle()
               .frame(width: geometry.size.width * CGFloat(configuration.fractionCompleted ?? 0),
                      height: height)
               .foregroundColor(filledColor)
               .clipShape(.rect(cornerRadius: height / 2))
         }
         .clipShape(.rect(cornerRadius: height / 2))
      }
      .frame(height: height)
   }
}

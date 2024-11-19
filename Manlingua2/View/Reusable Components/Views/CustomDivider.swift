//
//  CustomDivider.swift
//  Manlingua2
//
//  Created by Paulus Michael on 10/11/24.
//

import SwiftUI

struct CustomDivider: View {
   let color: Color
   let width: CGFloat = 1
   
   var body: some View {
      Rectangle()
         .fill(color)
         .frame(height: width)
   }
}

#Preview {
   CustomDivider(color: .white)
}

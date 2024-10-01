//
//  CompleteStatusLabel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct CompleteStatusLabel: View {
   @State var isComplete: Bool = false
   
   var body: some View {
      //TODO: Pake enum
      let labelText = isComplete ? "Completed" : "Not Completed"
      let foregroundColor = isComplete ? Color.green2 : Color.red
      let backgroundColor = isComplete ? Color.greenLight : Color.redLight
      
      Text(labelText)
         .foregroundStyle(foregroundColor)
         .fontWeight(.bold)
         .padding(.vertical, 8)
         .padding(.horizontal, 12)
         .background(backgroundColor)
         .clipShape(.rect(cornerRadius: 24))
         .padding(2)
   }
}

#Preview {
   CompleteStatusLabel(isComplete: false)
}


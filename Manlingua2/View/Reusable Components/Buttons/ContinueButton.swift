//
//  ContinueButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 13/10/24.
//

import SwiftUI

struct ContinueButton: View {
   var action: () -> Void
   
   var body: some View {
      Button(action: {
         action()
      }) {
         Text("Lanjut")
            .foregroundStyle(Color.white)
            .font(.button())
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.orange3)
            .clipShape(.rect(cornerRadius: 16))
      }
   }
}

#Preview {
   ContinueButton(action: {})
}

//
//  TryAgainButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 13/10/24.
//

import SwiftUI

struct TryAgainButton: View {
   var action: () -> Void
   
   var body: some View {
      Button(action: {
         action()
      }) {
         Text("Coba Lagi")
            .foregroundStyle(.orange3)
            .font(.button())
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(.rect(cornerRadius: 16))
            .overlay {
               RoundedRectangle(cornerRadius: 16)
                  .stroke(.orange3, lineWidth: 2)
            }
      }
   }
}

#Preview {
   TryAgainButton(action: {})
}

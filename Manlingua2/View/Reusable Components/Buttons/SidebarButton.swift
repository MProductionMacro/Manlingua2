//
//  SidebarButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 13/10/24.
//

import SwiftUI

struct SidebarButton: View {
   @State private var buttonOffset: CGFloat = 0 // Controls vertical position of the button
   @State private var dragOffset: CGSize = .zero
   
   var body: some View {
      GeometryReader { geometry in
         VStack {
            Spacer()
            
            Button(action: {
               // Button action here
            }) {
               Image(systemName: "chevron.right")
                  .foregroundColor(.white)
                  .frame(width: 50, height: 50)
                  .background(Color.orange)
                  .clipShape(Circle())
            }
            .offset(x: geometry.size.width - 50, y: buttonOffset + dragOffset.height) // Keeps it on the right side of the screen
            .gesture(
               DragGesture()
                  .onChanged { value in
                     // Update the button's offset directly to follow the user's finger
                     dragOffset = value.translation
                  }
                  .onEnded { value in
                     // Adjust the final position when the user ends the drag
                     let newOffset = buttonOffset + value.translation.height
                     buttonOffset = min(max(newOffset, 0), geometry.size.height - 50) // Constrain within screen bounds
                     dragOffset = .zero
                  }
            )
            Spacer()
         }
      }
   }
}

#Preview {
   SidebarButton()
}

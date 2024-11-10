//
//  BottomStoryButtons.swift
//  Manlingua2
//
//  Created by Paulus Michael on 09/11/24.
//

import SwiftUI

struct BottomContainerButtons: View {
   var bookAction: () -> Void
   var speakerAction: () -> Void
   var turtleAction: () -> Void
   
   var body: some View {
      HStack{
         Button {
            bookAction()
         } label: {
            Image(systemName: "book")
               .font(.titleKe2())
               .foregroundStyle(.orange3)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
         
         Button {
            speakerAction()
         } label: {
            Image(systemName: "speaker.wave.2")
               .font(.titleKe2())
               .foregroundStyle(.orange3)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
         
         Button {
            turtleAction()
         } label: {
            Image(systemName: "tortoise")
               .font(.titleKe2())
               .foregroundStyle(.orange3)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
      }
   }
}

#Preview {
   BottomContainerButtons(bookAction: {}, speakerAction: {}, turtleAction: {})
}

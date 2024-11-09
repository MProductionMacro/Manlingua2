//
//  ChatScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 31/10/24.
//

import SwiftUI

struct ChatScrollView: View {
   @Binding var currentIndex: Int
   var chats: [Chat_Example]
   var actionOnDone: () -> Void
   
   var body: some View {
      ScrollViewReader { proxy in
         ScrollView{
            VStack(spacing: 16){
               ForEach(0...currentIndex, id: \.self) { index in
                  let chat = chats[index]
                  
                  BubbleChatView(chat: .constant(chat), type: chat.type)
                     .id(index)
               }
               
               if currentIndex + 1 >= chats.count {
                  Button {
                     actionOnDone()
                  } label: {
                     Text("Continue")
                  }
               }
            }
         }
         .onChange(of: currentIndex) { oldValue, newValue in
            proxy.scrollTo(newValue, anchor: .bottom)
            print("Current index: \(currentIndex)")
            print("New index: \(newValue)")
            print("Old index: \(oldValue)")
            print("Chat Index: \(chats.count)")
         }
      }
//      .padding(.bottom, chats[currentIndex].type == .question ? 0 : 64)
   }
}

//#Preview {
//   ChatScrollView(currentIndex: <#Binding<Int>#>, chat: <#[Chat_Example]#>, actionOnDone: <#() -> Void#>)
//}

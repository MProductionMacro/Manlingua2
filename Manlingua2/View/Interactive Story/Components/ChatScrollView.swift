//
//  ChatScrollView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 31/10/24.
//

import SwiftUI

struct ChatScrollView: View {
   @Binding var currentIndex: Int
   @Binding var hasAnswered: Bool
   @Binding var modalAppeared: Bool
   
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
                        .frame(maxWidth: .infinity)
                  }
                  .id("button")
                  .padding(.horizontal)
                  .buttonStyle(PrimaryButton(isDisabled: false))
                  .onAppear{
                     proxy.scrollTo("button", anchor: .bottom)
                  }
               }
            }
         }
         .onChange(of: hasAnswered) { _, _ in
            // Scroll to bottom when hasAnswered changes
            withAnimation{
               proxy.scrollTo(currentIndex, anchor: .bottom)
            }
         }
         .onChange(of: modalAppeared, { oldValue, newValue in
            withAnimation{
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                  proxy.scrollTo(currentIndex, anchor: .bottom)
               }
            }
         })
         .onChange(of: currentIndex) { _, _ in
            withAnimation{
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                  proxy.scrollTo(currentIndex, anchor: .bottom)
               }
            }
         }
      }
      //      .padding(.bottom, chats[currentIndex].type == .question ? 0 : 64)
   }
}

//#Preview {
//   ChatScrollView(currentIndex: <#Binding<Int>#>, chat: <#[Chat_Example]#>, actionOnDone: <#() -> Void#>)
//}

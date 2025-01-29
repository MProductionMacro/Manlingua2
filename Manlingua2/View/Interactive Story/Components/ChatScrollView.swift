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
   
   var chats: [Chat]
   var actionOnDone: () -> Void
   
   var body: some View {
      ScrollViewReader { proxy in
         ScrollView{
            VStack(spacing: 8){
               ForEach(0...currentIndex, id: \.self) { index in
                  let chat = chats[index]
                  
                  BubbleChatView(chat: .constant(chat), type: chat.type, questionIndex: currentIndex, isActive: index == currentIndex, actionAfterTap: {
                     DispatchQueue.main.async {
                        proxy.scrollTo(index, anchor: .bottom)
                     }
                  })
                  .id(index)
               }
            }
            .onChange(of: modalAppeared, { oldValue, newValue in
               withAnimation{
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
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
}

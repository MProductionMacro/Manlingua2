//
//  QuestionBubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct QuestionBubbleChatView: View {
   var hanzi: String
   var pinyin: String
   var question: String
   
   @State private var showQuestionModal: Bool = false
   
   var body: some View {
      HStack {
         Spacer()
         
         HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 2) {
               Text(question)
                  .font(.subJudul())
                  .padding(.bottom, 8)
               
               Text(pinyin)
                  .font(.pinyin())
                  .fontWeight(.bold)
                  .foregroundColor(.gray)
               
               // Chinese characters
               Text(hanzi)
                  .font(.hanzi())
                  .foregroundColor(.black)
            }
            .padding(8)
            .background(
               ZStack(alignment: .topLeading) {
                  RoundedRectangle(cornerRadius: 8)
                     .fill(.customYellow)
               }
            )
            
            RightCustomTriangle(cornerRadius: 16)
               .fill(.customYellow)
               .frame(width: UIScreen.main.bounds.width * 0.03, height: UIScreen.main.bounds.height * 0.02)
               .padding(.top, 8)
         }
         
         Image(.orangeSpeaker2)
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.height  * 0.08)
      }
      .onAppear {
         showQuestionModal = true
      }
   }
}

#Preview {
   QuestionBubbleChatView(hanzi: "Halo", pinyin: "Halo", question: "Halo")
}

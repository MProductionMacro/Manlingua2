//
//  QuestionModalityView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 17/10/24.
//

import SwiftUI

struct QuestionModalityView: View {
   var columns = [
      GridItem(.flexible(), spacing: 20),
      GridItem(.flexible(), spacing: 20)
   ]
   
   var choices: [String]
   var onAnswerSelected: (String) -> Void
   
   var body: some View {
      VStack(spacing: 16) {
         Text("Pilih jawaban yang benar")
            .font(.titleKe2())
         
         LazyVGrid(columns: columns) {
            ForEach(choices, id: \.self) { choice in
               Button {
                  onAnswerSelected(choice)
               } label: {
                  Text(choice)
               }
               .buttonStyle(AnswerButton())
            }
         }
      }
      .padding(.horizontal)
      .background(.white)
   }
}

#Preview {
   QuestionModalityView(choices: ["Hello", "Hi", "Hey", "Here"], onAnswerSelected: {_ in })
      .frame(maxHeight: .infinity)
      .background(.black)
}

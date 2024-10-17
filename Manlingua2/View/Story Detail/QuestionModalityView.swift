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
   
   var onAnswerSelected: () -> Void // Closure to trigger when the user selects an answer
   
   var body: some View {
      VStack {
         Text("Pilih jawaban yang benar")
            .font(.judulBiasa())
            .padding(.vertical, 24)
         
         LazyVGrid(columns: columns) {
            ForEach(choices, id: \.self) { choice in
               Button {
                  onAnswerSelected()
               } label: {
                  Text(choice)
               }
               .buttonStyle(AnswerButton())
            }
         }
      }
      .padding(.horizontal)
      .padding(.bottom, 36)
//      .padding(.top)
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   QuestionModalityView(choices: ["Hello", "Hi", "Hey", "Here"], onAnswerSelected: {})
      .frame(maxHeight: .infinity)
      .background(.black)
}

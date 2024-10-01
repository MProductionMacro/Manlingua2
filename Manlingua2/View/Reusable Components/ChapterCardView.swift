//
//  ChapterCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 01/10/24.
//

import SwiftUI

struct ChapterCardView: View {
   var imageName: String
   var chapterNumber: Int
   var chapterTitle: String
   var options: [String]
   var selectedOption: Int?
   
   @Binding var isInactive: Bool
   @Binding var isFinished: Bool
   
   
   var body: some View {
      VStack(alignment: .leading) {
         HStack(spacing: 16) {
            Image(imageName)
               .resizable()
               .frame(width: 86, height: 86)
               .cornerRadius(12)
               .grayscale(isInactive ? 1.0 : 0.0)
            
            
            VStack(alignment: .leading, spacing: 6) {
               Text("Chapter \(chapterNumber)")
                  .font(.system(size: 14, weight: .regular))
                  .foregroundColor(.black)
               
               Text(chapterTitle)
                  .font(.system(size: 20, weight: .bold))
                  .foregroundStyle(.black)
            }
            Spacer()
         }
         .padding(.bottom, 16)
         
         ForEach(options.indices, id: \.self) { index in
            HStack {
               if isFinished == true {
                  Image(systemName: "checkmark.circle.fill")
                     .foregroundColor(.green)
               } else {
                  Image(systemName: "circle")
                     .foregroundColor(.gray)
               }
               
               Text(options[index])
                  .font(.system(size: 16, weight: .medium))
                  .foregroundColor(.black)
               
               Spacer()
               
               Image(systemName: "chevron.right")
                  .foregroundColor(isInactive ? .customLightGray : .orange3 )
            }
            .padding(.vertical, 8)
         }
      }
      .padding()
      .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
      .overlay(
         RoundedRectangle(cornerRadius: 16)
            .stroke(.customLightGray, lineWidth: 1)
      )
   }
}

#Preview {
   ChapterCardView(imageName: "SchoolChapter",
                   chapterNumber: 2,
                   chapterTitle: "Arrive at Haidilao",
                   options: ["Vocabulary", "Quiz", "Conversation"],
                   selectedOption: nil, isInactive: .constant(false), isFinished: .constant(false))
}

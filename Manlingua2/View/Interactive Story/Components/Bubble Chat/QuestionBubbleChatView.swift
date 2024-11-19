//
//  QuestionBubbleChatView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct QuestionBubbleChatView: View {
   @EnvironmentObject var storyVM: StoryViewModel
   
   var hanzi: String
   var pinyin: String
   var question: String
   var meaning: String
   var isActive: Bool
   
   @State private var showQuestionModal: Bool = false
   @State private var showMeaningModal: Bool = false
   
   var body: some View {
      VStack {
         HStack(alignment: .top, spacing: 4) {
            Spacer()
            
            HStack(alignment: .top, spacing: 0) {
               if isActive {
                  Image(systemName: "exclamationmark.circle.fill")
                     .foregroundStyle(.orange1)
                     .offset(x: UIScreen.main.bounds.width * 0.025, y: -UIScreen.main.bounds.width * 0.02)
                     .zIndex(1)
               }
               
               VStack(spacing: 0) {
                  VStack(alignment: .leading, spacing: 2) {
                     Text(question)
                        .font(.subJudul())
                        .padding(.bottom, 8)
                     
                     Text(pinyin)
                        .font(.pinyin())
//                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                     
                     // Chinese characters
                     Text(hanzi)
                        .font(.hanzi())
                        .foregroundColor(.black)
                        .onTapGesture {
                           showMeaningModal.toggle()
                        }
                  }
                  .padding(8)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .fixedSize(horizontal: false, vertical: true)
                  
                  if showMeaningModal {
                     VStack(alignment: .leading) {
                        CustomDivider(color: .white)
                        
                        Text(meaning)
                           .font(.system(size: 14))
                           .multilineTextAlignment(.leading)
                           .padding([.horizontal, .bottom], 8)
                     }
                     .frame(maxWidth: .infinity, alignment: .leading)
                  }
               }
               .background(
                  ZStack(alignment: .topLeading) {
                     RoundedRectangle(cornerRadius: 8)
                        .fill(.green1)
                  }
               )
               
               RightCustomTriangle(cornerRadius: 16)
                  .fill(.green1)
                  .frame(width: UIScreen.main.bounds.width * 0.035, height: UIScreen.main.bounds.height * 0.025)
                  .offset(x: -UIScreen.main.bounds.width * 0.004)
                  .padding(.top, UIScreen.main.bounds.height * 0.005)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(width: UIScreen.main.bounds.width * 0.6)
            
            Image(.orangeSpeaker2)
               .resizable()
               .scaledToFit()
               .frame(width: UIScreen.main.bounds.width * 0.12, height: UIScreen.main.bounds.height * 0.06)
         }
         .onAppear {
            showQuestionModal = true
         }
      }
      .frame(maxHeight: UIScreen.main.bounds.height * 0.25)
   }
}

#Preview {
   QuestionBubbleChatView(hanzi: "Halo", pinyin: "Halo", question: "Halo", meaning: "Halo", isActive: true)
      .background(.black)
      .environmentObject(StoryViewModel())
}

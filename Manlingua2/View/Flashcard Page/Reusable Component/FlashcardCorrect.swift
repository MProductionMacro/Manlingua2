//
//  FlashcardCorrect.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import SwiftUI

struct FlashcardCorrect: View {
   var hanzi: String
   var pinyin: String
   var meaning: String
   @ObservedObject var viewModel: StoryViewModel
    @Binding var showMicrophone: Bool
    var action: () -> Void

   var body: some View {
      VStack(alignment: .leading, spacing: 24) {
         VStack(alignment: .leading) {
            HStack(spacing: 12) {
               Button {
                  
               } label: {
                  Image(systemName: "waveform")
                     .foregroundStyle(.white)
                     .font(.judulBiasa())
                     .padding(12)
                     .background(.orange3)
                     .cornerRadius(16)
               }
               
               Image(systemName: "checkmark.circle.fill")
                  .foregroundColor(Color.green2)
                  .font(.title)
               
               VStack(alignment: .leading) {
                  Text("wán quán zhèng què!")
                     .foregroundStyle(Color.green2)
                     .font(.pinyin())
                     .fontWeight(.bold)
                  
                  Text("完全正确")
                     .foregroundStyle(.green2)
                     .font(.judulBiasa())
               }
            }
            
            HStack {
               Text("Kamu terdengar seperti penutur asli!")
                  .foregroundStyle(.black)
                  .font(.subJudul())
            }
         }
         
         HStack(spacing: 16) {
            TryAgainButton(action: {
                showMicrophone.toggle()
            })
            
            ContinueButton(action: {
               action()
            })
         }
      }
      .frame(width: 368, height: 180)
      //.frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.vertical, 24)
      .background(.greenLight)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
   }
}

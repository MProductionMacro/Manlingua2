//
//  FlashcardWrong.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import SwiftUI

struct FlashcardWrong: View {
   var hanzi: String
   var meaning: String
   @ObservedObject var viewModel: StoryViewModel
    @Binding var showMicrophone: Bool
    @Binding var audioController: AudioController
    var action: () -> Void

   var body: some View {
      VStack(alignment: .leading, spacing: 24) {
         VStack(alignment: .leading) {
            HStack(spacing: 12) {
               Button {
                   audioController.playRecording()
               } label: {
                  Image(systemName: "waveform")
                     .foregroundStyle(.white)
                     .font(.judulBiasa())
                     .padding(12)
                     .background(.orange3)
                     .cornerRadius(16)
               }
               
               Image(systemName: "x.circle.fill")
                  .foregroundColor(.redNormal)
                  .font(.title)
               
               VStack(alignment: .leading) {
                  Text("wán quán zhèng què!")
                     .foregroundStyle(.redNormal)
                     .font(.pinyin())
                     .fontWeight(.bold)
                  
                  Text("完全正确")
                     .foregroundStyle(.redNormal)
                     .font(.judulBiasa())
                     .fontWeight(.regular)
               }
            }
            
            HStack {
               Text("\(hanzi) artinya '\(meaning)'")
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
      .padding()
      .background(.redLight)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
   }
}

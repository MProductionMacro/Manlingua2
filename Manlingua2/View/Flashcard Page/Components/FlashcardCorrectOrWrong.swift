//
//  FlashcardCorreectOrWrong.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 20/11/24.
//

import SwiftUI

struct FlashcardCorrectOrWrong: View {
   @Binding var answer:String
   var hanzi: String
   var pinyin: String
   var meaning: String
   var isCorrect: Bool
   
   var continueFunc: () -> Void
   var tryAgainFunc: () -> Void
   @State var audioController = AudioController.shared
   @State var transcribedAudio = ""
   @State private var isTransitioning: Bool = false

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
                     .background(.orangeDarkMode)
                     .cornerRadius(16)
               }
               
               Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                  .foregroundColor(isCorrect ? .green2 : .redNormal)
                  .font(.title)
               
               VStack(alignment: .leading) {
                  Text(isCorrect ? "wán quán zhèng què!" : "hái cuò ,       zài   shì   yī    cì")
                     .foregroundStyle(isCorrect ? .green2 : .redNormal)
                     .font(.pinyin())
                     .fontWeight(.bold)
                  
                  Text(isCorrect ? "完全正确" : "还错，再试一次")
                     .foregroundStyle(isCorrect ? .green2 : .redNormal)
                     .font(.judulBiasa())
               }
            }
            
            
            HStack {
               Text("Anda mengucapkan ".localized + "\(transcribedAudio)")
                  .foregroundStyle(.black)
                  .font(.subJudul())
                  .onAppear {
                     audioController.transcribeAudio { result in
                        transcribedAudio = result
                     }
                  }
               
//               if answer == "Transcription error: No speech detected" || answer.replacingOccurrences(of: " ", with: "") == ""{
//                  Text("No characters detected".localized)
//                     .foregroundStyle(.black)
//                     .font(.subJudul())
//               }else{
//                  Text("Anda mengucapkan".localized + " \(answer)")
//                     .foregroundStyle(.black)
//                     .font(.subJudul())
//               }
            }
         }
         
         HStack(spacing: 16) {
            TryAgainButton(action: {
               tryAgainFunc()
            })
            
            ContinueButton(action: {
                withAnimation{
                    guard !isTransitioning else { return }
                    isTransitioning = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                       isTransitioning = false
                    }
                    continueFunc()
                }
            })
         }
      }
      .edgesIgnoringSafeArea(.bottom)
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.vertical, 24)
      //      .padding(.bottom, 36)
      .background(isCorrect ? .greenLight : .redLight)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   FlashcardCorrectOrWrong(answer: .constant("Tes"), hanzi: "猫", pinyin: "Māo", meaning: "How many people", isCorrect: true, continueFunc: {}, tryAgainFunc: {})
}


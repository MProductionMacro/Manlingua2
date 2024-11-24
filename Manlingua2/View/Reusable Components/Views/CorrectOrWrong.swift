//
//  View.swift
//  HXD
//
//  Created by Ferdinand Jacques on 01/08/24.
//

import SwiftUI

struct CorrectOrWrong: View {
   @Binding var isSpeakingQuestion: Bool
   var hanzi: String
   var pinyin: String
   var meaning: String
   var isCorrect: Bool
   //   var isCamera: Bool
   var type: ModalityType
   
   var continueFunc: () -> Void
   var tryAgainFunc: () -> Void
   
   @State var transcribedAudio = ""
   
   @State var audioController = AudioController.shared
   @State var textToSpeech = TextToSpeech.shared
   @State private var checkMessages: String = ""
   
   var body: some View {
      VStack(alignment: .leading, spacing: 16) {
         VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
               Button {
                  if type == .speakingQuestion {
                     audioController.playRecording()
                  }
                  else{
                     textToSpeech.speakSlow(text: hanzi)
                  }
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
            
            switch type {
            case .writingQuestion:
               HStack(alignment: .bottom, spacing: 0) {
                  VStack {
                     Text("\(pinyin)")
                        .font(.pinyin())
                     
                     Text("\(hanzi) ")
                        .font(.subJudul())
                  }
                  
                   Text("artinya".localized + " \(meaning)")
                     .font(.subJudul())
               }
               .foregroundStyle(.black)
            case .speakingQuestion:
                Text(checkMessages)
                   .foregroundStyle(.black)
                   .font(.subJudul())
                   .onAppear {
                      audioController.transcribeAudio { result in
                         transcribedAudio = result
                        
                          if result.hasPrefix("Transcription error:") {
                              checkMessages = "No characters detected".localized
                          }
                          else{
                              checkMessages = "Anda mengucapkan".localized + " \(transcribedAudio)"
                          }
                          
                      }
                   }
            case .cameraQuestion:
               Text(isCorrect ? "Tepat sekali!" : "Masih belum tepat!")
                  .font(.subJudul())
                  .foregroundStyle(.black)
            }
         }
         
         HStack(spacing: 16) {
            TryAgainButton(action: {
               tryAgainFunc()
            })
            
            ContinueButton(action: {
               continueFunc()
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
      .onAppear {
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            audioController.playSoundFromData(speak: isCorrect ? "Correct" : "Wrong")
         }
      }
   }
}

enum ModalityType {
   case writingQuestion
   case speakingQuestion
   case cameraQuestion
}

//#Preview {
//   CorrectOrWrong(isSpeakingQuestion: .constant(true), hanzi: "猫", pinyin: "Māo", meaning: "How many people", isCorrect: true, continueFunc: {}, tryAgainFunc: {})
//      .preferredColorScheme(.dark)
//}

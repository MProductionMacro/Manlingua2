//
//  AudioBTN.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct AudioBTN: View {
   @EnvironmentObject private var audioRecorder: AudioRecordAndSpeechController
   
   @Binding var transcribedText: String
   
   @State private var isRecording = false
   @State private var isPlayingSpeech = false
   
   var onPressedMic: (String) -> Void
   
   var body: some View {
      VStack {
         // Recording Button
         Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
            .foregroundColor(isRecording ? .red : .orange3)
            .simultaneousGesture(
               DragGesture(minimumDistance: 0)
                  .onChanged { _ in
                     if !isRecording {
                        self.isRecording = true
                        audioRecorder.startRecording()
                     }
                  }
                  .onEnded { _ in
                     if isRecording {
                        self.isRecording = false
                        audioRecorder.stopRecording()
                        audioRecorder.transcribeAudio { result in
                           DispatchQueue.main.async {
                              self.transcribedText = result
                           }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                           onPressedMic(transcribedText)
                        })
                     }
                  }
            )
            .padding(.bottom)
      }
   }
}

//#Preview {
//   AudioBTN(responseText: .constant("Hello"), actionOnPressed: {})
//}

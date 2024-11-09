//
//  AudioBTN.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct AudioBTN: View {
   //   @EnvironmentObject private var audioRecorder: AudioRecordAndSpeechController
   
   private let instance = APIController.instance
   
   @Binding var message:  String
   @Binding var showMicrophone: Bool
   
   @State var audioController = AudioController.shared
   @State private var isRecording = false
   @State private var isPlayingSpeech = false
   
   var onPressedMic: (String) -> Void
   
   func sendAudioToAPI() {
      guard let audioURL = audioController.getAudioFileName() else {
         print("No audio file to send")
         return
      }
      
      Task {
         if let response = await APIController.instance.getResponse(audioPath: audioURL.path) {
            print("API response: \(response)")
            message = response
            showMicrophone.toggle()
         } else {
            print("Failed to get API response")
         }
      }
   }
   
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
                        audioController.startRecording()
                     }
                  }
                  .onEnded { _ in
                     if isRecording {
                        self.isRecording = false
                        audioController.stopRecording()
                        
                        audioController.transcribeAudio { result in
                           onPressedMic(result)
                        }
                     }
                  }
            )
//            .padding(.bottom)
      }
   }
}

//#Preview {
//   AudioBTN(responseText: .constant("Hello"), actionOnPressed: {})
//}

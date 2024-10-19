//
//  AudioBTN.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct AudioBTN: View {
   private let controller = AudioController()
   private let instance = APIController.instance
   
   @State var color : Color = .black
   
   @Binding var responseText : String
   //   @Binding var showMicrophone: Bool
   
   var actionOnPressed : (String) -> Void
   
   func sendAudioToAPI() {
      guard let audioURL = controller.getAudioFileName() else {
         print("No audio file to send")
         return
      }
      
      
      Task {
         if let response = await APIController.instance.getResponse(audioPath: audioURL.path) {
            print("API response: \(response)")
            responseText = response
         } else {
            print("Failed to get API response")
         }
      }
   }
   
   var body: some View {
      Image(systemName:"mic.fill")
         .font(.system(size: 50))
         .foregroundColor(color)
         .padding()
         .background(Circle()
            .fill(Color(.systemBackground))
            .shadow(radius: 4))
         .onLongPressGesture (
            minimumDuration: 0.2,
            perform: {
               self.color = .blue
               controller.startRecording()
            },
            onPressingChanged: { changes in
               if changes {
                  
               } else {
                  self.color = .orange
                  controller.stopRecording()
                  if let path = controller.getAudioFileName()?.path{
                     APIController.instance.convertAudioToData(audioPath:path)
                     sendAudioToAPI()
                     
                     actionOnPressed(responseText)
                  }
                  else{
                     print("Error getting audio file")
                  }
                  //APIController.instance.convertAudioToData(audioPath: controller.getAudioFileName()!.path())
                  //sendAudioToAPI()
                  
               }
               
            }
         )
         .onAppear{
            controller.requestPermission { granted in
                if granted{
                    print("Granted Permission")
                }else{
                    print("Denied Permission")
                }
            }
         }
   }
}

//#Preview {
//   AudioBTN(responseText: .constant("Hello"), actionOnPressed: {})
//}

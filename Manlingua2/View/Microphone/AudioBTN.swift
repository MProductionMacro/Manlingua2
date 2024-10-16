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
            },
            onPressingChanged: { changes in
               // changes dia awal pencet itu true buat ngerecord
               if changes {
                  //                                                controller.startRecording()
               }
               // kalau false kirim data ke API
               else {
                  //                                                controller.stopRecording()
                  self.color = .black
                  
                  print("\(String(describing: controller.getAudioFileName()))")
                  //                        //baru data urlnya di kirim ke API
                  //                        if let audioURL = controller.getAudioFileName() {
                  //
                  //                            Task{
                  //                                if let response = await instance.getResponse(audioPath: audioURL.path){
                  //                                    responseText = response
                  //                                }
                  //                                else {
                  //                                    responseText = "Failed to get text"
                  //                                }
                  //                            }
                  //                        }
                  //
                  //
               }
               
            }
         )
      
      
   }
}

#Preview {
   AudioBTN(responseText: .constant("Hello"))
}

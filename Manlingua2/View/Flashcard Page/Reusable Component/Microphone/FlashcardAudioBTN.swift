//
//  AudioBTN.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct FlashcardAudioBTN: View {
    //private let controller = AudioController()
    private let instance = APIController.instance
    
    @State var color : Color = .white
    @State var responseText : String = ""
    
    @State private var isRecording = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isAllowSendAPI = true
    
    
    @Binding var message:  String
    @Binding var showMicrophone: Bool
    @Binding var audioController: AudioController

    init(message: Binding<String>, showMicrophone: Binding<Bool>, audioController: Binding<AudioController>){
        _message = message  // Menginisialisasi @Binding dari parent
        _showMicrophone = showMicrophone
        _audioController = audioController
        self.audioController.requestPermission { granted in
            if granted{
                print("Granted Permission")
            }else{
                print("Denied Permission")
            }
        }
    }


    func sendAudioToAPI() {
        guard let audioURL = audioController.getAudioFileName() else {
            print("No audio file to send")
            isAllowSendAPI = true
            return
        }
        
        
        Task {
            if let response = await APIController.instance.getResponse(audioPath: audioURL.path) {
                print("API response: \(response)")
                message = response
                showMicrophone.toggle()
                isAllowSendAPI = true
            } else {
                print("Failed to get API response")
                isAllowSendAPI = true
            }
        }
    }
    
    func sendAudioToAPISecond() {
        guard let audioURL = audioController.getAudioFileName() else {
            print("No audio file to send")
            return
        }
        
        Task {
            if let response = await APIController.instance.getResponseSecond(audioPath: audioURL.path) {
                print("API response: \(response)")
                message = response
            } else {
                print("Failed to get API response")
            }
        }
    }

    
    var body: some View {
        VStack{
            Image(systemName:"mic.fill")
                .font(.system(size: 50))
                .foregroundColor(color)
                .padding()
                .background(Circle()
                    .fill(Color.orange)
                    .shadow(radius: 4))
                .onLongPressGesture (
                    minimumDuration: 0.1,
                    perform: {
                        self.color = .gray
                        if isAllowSendAPI {
                            audioController.startRecording()
                        }
                    },
                    onPressingChanged: { changes in
                        // changes dia awal pencet itu true buat ngerecord
                        if changes {
                            //do nothing karena uda di perform
                            
                        }
                        // kalau false kirim data ke API
                        else {
                            self.color = .white
                            if isAllowSendAPI {
                                audioController.stopRecording()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    if let path = audioController.getAudioFileName()?.path{
                                        instance.convertAudioToData(audioPath:path)
                                        sendAudioToAPI()
                                    }
                                    else{
                                        print("Error getting audio file")
                                    }
                                }
                                isAllowSendAPI = false
                            }

                            //APIController.instance.convertAudioToData(audioPath: controller.getAudioFileName()!.path())
                            //sendAudioToAPI()
                            
                        }
                        
                    }
                )
        }
    }
}
/*
#Preview {
    AudioBTN(message: Binding<String>(initialValue:"Hello, World!")
}
*/

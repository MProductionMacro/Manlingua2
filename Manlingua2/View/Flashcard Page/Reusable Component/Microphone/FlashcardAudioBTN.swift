//
//  AudioBTN.swift
//  Manlingua2
//
//  Created by Paulus Michael on 16/10/24.
//

import SwiftUI

struct FlashcardAudioBTN: View {
    private let controller = AudioController()
    private let instance = APIController.instance
    
    @State var color : Color = .white
    @State var responseText : String = ""
    
    @State private var isRecording = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var message:  String
    @Binding var showMicrophone: Bool


    init(message: Binding<String>, showMicrophone: Binding<Bool>){
        
        _message = message  // Menginisialisasi @Binding dari parent
        _showMicrophone = showMicrophone
        controller.requestPermission { granted in
            if granted{
                print("Granted Permission")
            }else{
                print("Denied Permission")
            }
        }
        
    }


    func sendAudioToAPI() {
        guard let audioURL = controller.getAudioFileName() else {
            print("No audio file to send")
            return
        }
        
        
        Task {
            if let response = await APIController.instance.getResponse(audioPath: audioURL.path) {
                print("API response: \(response)")
                message = response
            } else {
                print("Failed to get API response")
            }
        }
    }
    
    func sendAudioToAPISecond() {
        guard let audioURL = controller.getAudioFileName() else {
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
                        controller.startRecording()
                    },
                    onPressingChanged: { changes in
                        // changes dia awal pencet itu true buat ngerecord
                        if changes {
                            //do nothing karena uda di perform
                            
                        }
                        // kalau false kirim data ke API
                        else {
                            self.color = .orange
                            controller.stopRecording()
                            if let path = controller.getAudioFileName()?.path{
                                APIController.instance.convertAudioToData(audioPath:path)
                                sendAudioToAPI()
                                showMicrophone.toggle()
                            }
                            else{
                                print("Error getting audio file")
                            }
                            //APIController.instance.convertAudioToData(audioPath: controller.getAudioFileName()!.path())
                            //sendAudioToAPI()
                            
                        }
                        
                    }
                )
            
            /*
            Button(action:{
                print("Button Pressed")
                controller.playRecording()
                
            }){
                Image(systemName: "play.circle.fill").font(.system(size: 60))
            }
            
            Button (action:{
                print("\(String(describing: instance.convertAudioToData(audioPath: controller.getAudioFileName()!.path())))")
            }){
                Image(systemName: "map.circle.fill").font(.system(size: 60))
            }
            Button (action:{
                //            instance.getResponse(audioPath: controller.getAudioFileName()!.path())
                sendAudioToAPI()
                
            }){
                Image(systemName: "circle.fill").font(.system(size: 60)).foregroundStyle(Color(.red))
            }
            
            Button (action:{
                //            instance.getResponse(audioPath: controller.getAudioFileName()!.path())
    //            print(String(describing: instance.getApiKey()))
                sendAudioToAPISecond()
            }){
                Image(systemName: "circle.fill").font(.system(size: 60)).foregroundStyle(Color(.yellow))
            }
            Text(message)
            
            Button (action:{
                //            instance.getResponse(audioPath: controller.getAudioFileName()!.path())
    //            print(String(describing: instance.getApiKey()))
                //controller.playSoundFromData(speak: "SoundTest")
            }){
                Image(systemName: "circle.fill").font(.system(size: 60)).foregroundStyle(Color(.green))
            }

            
            //        Button(action: {}) {
            //                    Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle")
            //                        .font(.system(size: 60))
            //                        .foregroundColor(isRecording ? .red : .orange)
            //                }
            //                .gesture(
            //                    LongPressGesture(minimumDuration: 0.3)
            //                        .onEnded { _ in
            //                            print("abc")
            //                        }
            //                )
            //                .alert(isPresented: $showAlert) {
            //                    Alert(title: Text("Recording"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            //                }
            */
        }

        
    }
    
}
/*
#Preview {
    AudioBTN(message: Binding<String>(initialValue:"Hello, World!")
}
*/

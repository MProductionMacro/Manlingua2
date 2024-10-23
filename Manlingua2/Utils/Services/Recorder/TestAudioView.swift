//
//  TestAudioView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 22/10/24.
//

import SwiftUI

struct TestAudioView: View {
   @StateObject private var viewModel = AudioRecorderViewModel()
   
   var body: some View {
      VStack(spacing: 20) {
         Text("Audio Recorder")
            .font(.largeTitle)
         
         Button(action: {
            viewModel.requestPermissionAndRecord()
         }) {
            Text(viewModel.isRecording ? "Stop Recording" : "Start Recording")
               .font(.title)
               .padding()
               .foregroundColor(.white)
               .background(viewModel.isRecording ? Color.red : Color.blue)
               .cornerRadius(10)
         }
         .disabled(viewModel.isPlaying)
         
         Button(action: {
            viewModel.playRecording()
         }) {
            Text("Play Recording")
               .font(.title)
               .padding()
               .foregroundColor(.white)
               .background(Color.green)
               .cornerRadius(10)
         }
         .disabled(viewModel.isRecording || !viewModel.hasRecording)
      }
      .padding()
   }
}

#Preview {
   TestAudioView()
}

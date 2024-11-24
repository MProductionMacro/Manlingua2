//
//  SwiftUIView.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 12/11/24.
//

import SwiftUI
import SiriWaveView

struct AIAssistantView: View {
   @State var aiAssistantViewModel = AIAssistantViewModel()
   @EnvironmentObject var router: Router
   @StateObject var audioController = AudioController.shared
   @State var isSymbolAnimating = false
//   @State var message = ""
//   @State var showMicrophone = true
//   @State var power = 0.0
   
   var body: some View {
      VStack(spacing: 16) {
         SiriWaveView(power: $aiAssistantViewModel.audioPower)
            .opacity(aiAssistantViewModel.siriWaveFormOpacity)
            .frame(height: 256)
            .overlay(overlayView)
         
         Spacer()
          switch aiAssistantViewModel.state {
         case .recordingSpeech:
            Text("Sedang Merekam".localized)
               .font(.system(size: 20, weight: .medium, design: .rounded)).animation(.easeInOut)
            cancelRecordingButton
            
         case .processingSpeech, .playingSpeech:
            Text("Batalkan memproses".localized)
               .font(.system(size: 20, weight: .medium, design: .rounded)).animation(.easeInOut)
            
            cancelButton
            
         case .idle:
            
            Text("Tekan Untuk Memulai".localized)
               .font(.system(size: 20, weight: .medium, design: .rounded)).animation(.easeInOut)
            startCaptureButton
              
              
            
            
            
         default: EmptyView()
         }
         
         Spacer()
          
//        Picker("Select Voice", selection: $aiAssistantViewModel.selectedVoice) {
//              ForEach(VoiceType.allCases, id: \.self) {
//                  Text($0.rawValue).id($0)
//              }
//          }
//          .pickerStyle(.segmented)
//          .disabled(!aiAssistantViewModel.isIdle)
         
         // Kalau ada error bisa muncul disini
         if case let .error(error) = aiAssistantViewModel.state {
            Text(error.localizedDescription)
               .foregroundStyle(.red)
               .font(.caption)
               .lineLimit(2)
         }
      }
      .toolbar {
          ToolbarItem(placement: .topBarLeading) {
              HStack(alignment: .top){
                  Button(action:{
                      router.pop()
                  }){
                      Image(systemName: "chevron.left")
                         .foregroundColor(.orangeDarkMode)
                         .font(.semibold16())
                         .bold()
                      
                       Text("Kembali".localized)
                         .foregroundColor(.orangeDarkMode)
                         .font(.semibold20())
                  }
              }
          }
      }
      .padding()
   }
   
   @ViewBuilder
    var overlayView: some View {
        switch aiAssistantViewModel.state {
        case .idle, .error:
            EmptyView()
        case .processingSpeech:
            Image(systemName: "brain")
                .symbolEffect(.bounce.up.byLayer, options: .repeating, value: isSymbolAnimating)
                .font(.system(size: 128))
                .onAppear { isSymbolAnimating = true }
                .onDisappear { isSymbolAnimating = false }
        default: EmptyView()
        }
    }
   
   var startCaptureButton: some View {
      Button {
         aiAssistantViewModel.startCaptureAudio()
      } label: {
         Image(systemName: "mic.circle.fill")
            .symbolRenderingMode(.multicolor)
            .font(.system(size: 70))
      }.buttonStyle(.borderless)
   }
   var cancelRecordingButton: some View {
      Button(role: .destructive) {
         aiAssistantViewModel.cancelRecording()
      } label: {
         Image(systemName: "xmark.circle.fill")
            .symbolRenderingMode(.multicolor)
            .font(.system(size: 60))
      }.buttonStyle(.borderless)
      
   }
   
   var cancelButton: some View {
      Button(role: .destructive) {
         aiAssistantViewModel.cancelProcessingTask()
      } label: {
         Image(systemName: "stop.circle.fill")
            .symbolRenderingMode(.monochrome)
            .foregroundStyle(.red)
            .font(.system(size: 44))
      }.buttonStyle(.borderless)
      
   }
}



//#Preview {
//   AIAssistantView()
//}


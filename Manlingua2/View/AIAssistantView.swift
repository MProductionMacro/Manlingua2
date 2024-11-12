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
    @State var isSymbolAnimating = false
    
    var body: some View {
        VStack(spacing: 16) {
            SiriWaveView(power: $aiAssistantViewModel.audioPower)
                .opacity(aiAssistantViewModel.siriWaveFormOpacity)
                .frame(height: 500)
                .overlay(overlayView)
            
            Spacer()
            switch aiAssistantViewModel.state {
            case .recordingSpeech:
                Text("Sedang Merekam")
                    .font(.system(size: 20, weight: .medium, design: .rounded)).animation(.easeInOut)
                cancelRecordingButton
                
            case .processingSpeech, .playingSpeech:
                Text("Batalkan memproses")
                    .font(.system(size: 20, weight: .medium, design: .rounded)).animation(.easeInOut)

                cancelButton
                
            case .idle:
               
                Text("Tekan Untuk Memulai")
                    .font(.system(size: 20, weight: .medium, design: .rounded)).animation(.easeInOut)
                    startCaptureButton
                    

                
            default: EmptyView()
            }
            
            Spacer()
            
            // Kalau ada error bisa muncul disini
            if case let .error(error) = aiAssistantViewModel.state {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .lineLimit(2)
            }
        }.padding()
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


#Preview {
   AIAssistantView()
}

//
//  FlashcardSideButton.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 16/10/24.
//
import SwiftUI

struct FlashcardSidebarButton: View {
   @State private var showContent: Bool = false
    @ObservedObject var viewModel: FlashcardViewModel
    @State var tts = TextToSpeech()
    var action: () -> Void // Fungsi sebagai parameter

   var body: some View {
      HStack(spacing: 0) {
          Button(action: {
            withAnimation {
               showContent.toggle()
                action()
            }
         }) {
            Image(systemName: showContent ? "chevron.right" : "chevron.left")
               .font(.judulBiasa())
               .foregroundColor(.white)
               .padding(.vertical, 11)
               .padding(.horizontal, 8)
         }
         
         if showContent {
            HStack(spacing: 12) {
               Button(action: {
                  
               }) {
                  Image(systemName: "book.fill")
                     .frame(width: 24, height: 24)
                     .padding(12)
                     .foregroundStyle(.white)
                     .background(.orange3)
                     .clipShape(.rect(cornerRadius: 12))
               }
               
               Button(action: {
                  // Action for speaker icon
                   tts.speak(text: viewModel.showVocabularies[viewModel.currentIndex].hanzi)
               }) {
                  Image(systemName: "speaker.wave.2.fill")
                     .frame(width: 24, height: 24)
                     .padding(12)
                     .foregroundStyle(.white)
                     .background(.orange3)
                     .clipShape(.rect(cornerRadius: 12))
               }
               
               Button(action: {
                  // Action for turtle icon
                   tts.speakSlow(text: viewModel.showVocabularies[viewModel.currentIndex].hanzi)
               }) {
                  Image(systemName: "tortoise.fill")
                     .frame(width: 24, height: 24)
                     .padding(12)
                     .foregroundStyle(.white)
                     .background(.orange3)
                     .clipShape(.rect(cornerRadius: 12))
               }
            }
            .padding(.horizontal, 12)
            .transition(.move(edge: .trailing)) // Animate appearance from the left side
         }
      }
      .padding(.vertical, 11)
      .background(.customYellow)
      .clipShape(CustomRoundedRectangle(cornerRadius: 20, corners: [.topLeft, .bottomLeft]))
      .frame(maxWidth: .infinity, alignment: .trailing)
   }
}

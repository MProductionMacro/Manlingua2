//
//  FlashcardViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import Foundation
import SwiftUI

class FlashcardViewModel: ObservableObject {
   @Published var currentIndex: Int = 0
   @Published var offset: CGSize = .zero
   @Published var showMicrophone: Bool = true
   @Published var showDonePage: Bool = false
   @Published var vocabularies: [Vocabulary] = []
   @Published var showVocabularies: [Vocabulary] = []
   @Published var apiResult = ""
   
   init(){
      loadVocabularies()
      reshuffleCards()
   }
   
   func checkResult() -> Bool{
      return apiResult == vocabularies[currentIndex].hanzi
   }
   
   func loadVocabularies() {
      for index in 1..<5 {
         for subIndex in 1..<4 {
            loadVocabularyFile(named: "Kosakata\(index)_\(subIndex)")
         }
      }
   }
   
   private func loadVocabularyFile(named filename: String) {
      guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
         print("Error: File '\(filename).json' not found.")
         return
      }
      
      do {
         let data = try Data(contentsOf: url)
         let vocabulary = try JSONDecoder().decode([Vocabulary].self, from: data)
         self.vocabularies.append(contentsOf: vocabulary)
      } catch {
         print("Error decoding JSON from '\(filename).json': \(error.localizedDescription)")
      }
   }
   
   func reshuffleCards(limit: Int = 10) {
      vocabularies.shuffle()
      showVocabularies = Array(vocabularies.prefix(limit))
   }
   
   
   func performSwipeRight() {
      guard currentIndex <= showVocabularies.count else {
         return
      }
      
      showMicrophone = true
      
      withAnimation {
         self.offset = CGSize(width: 500, height: 0)
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.offset = .zero
            if self.currentIndex == self.showVocabularies.count - 1{
               self.showDonePage = true
            }
            else {
               self.currentIndex = min(self.currentIndex + 1, self.vocabularies.count-1 )
            }
         }
      }
   }
   
   func createFlashcardView(for index: Int) -> some View {
      let flashcardView = FlashcardView(vocab: showVocabularies[index], width: 300, height: 400)
         .frame(width: 300, height: 400)
      var modifiedView: AnyView = AnyView(flashcardView)
      
      if index == currentIndex {
         modifiedView = AnyView(modifiedView
            .opacity(1.0)
            .offset(x: offset.width)
            .offset(y: offset.height * 0.4)
            .rotationEffect(.degrees(offset.width / 40.0))
            .animation(.spring(), value: offset)
         )
      }else if index == currentIndex - 1 {
         modifiedView = AnyView(modifiedView
            .opacity(1.0)
            .offset(x: -300 + offset.width)
            .zIndex(Double(showVocabularies.count - index))
            .animation(.spring(), value: offset)
         )
      }
      return modifiedView
   }
   
   func getProgress() -> Double {
      return Double(currentIndex+1)/Double(showVocabularies.count)
   }
}

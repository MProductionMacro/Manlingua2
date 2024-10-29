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
   
   func getProgress() -> Double {
      return Double(currentIndex+1)/Double(showVocabularies.count)
   }
}

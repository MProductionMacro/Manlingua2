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
    //@Published var checkResult: Bool = false
    @Published var showMicrophone: Bool = true
    @Published var flashcards: [Flashcard_Example] = []
    @Published var showFlashcards: [Flashcard_Example] = []
    @Published var showDonePage: Bool = false
    
    
    @Published var vocabularies: [Vocabulary] = []
    @Published var showVocabularies: [Vocabulary] = []
    @Published var apiResult = ""
    
    init(){
        loadVocabularies()
        reshuffleCards()
    }
    
    func checkResult() -> Bool{
        if apiResult == vocabularies[currentIndex].hanzi{
            return true
        }
        return false
    }
    
    func loadVocabularies(){
        for index in 1..<5{
            var vocabulary = [Vocabulary]()
            for subIndex in 1..<4{
                guard let url = Bundle.main.url(forResource: "Kosakata\(index)_\(subIndex)", withExtension: "json") else {
                    print("File not found: Kosakata\(index)_\(subIndex)")
                    return
                }
                
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    vocabulary = try decoder.decode([Vocabulary].self, from: data)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            self.vocabularies.append(contentsOf: vocabulary)
        }
    }
    
    func reshuffleCards(){
        //flashcards.shuffle()
        //showFlashcards = Array(flashcards.prefix(5))
        vocabularies.shuffle()
        showVocabularies = Array(vocabularies.prefix(10))
    }
    
    func getCurrentStory() -> Story {
        return stories[currentStoryIndex]
    }
   
    func performSwipeLeft() {
        //guard currentIndex > 0 else { return }
        withAnimation(nil) {
            offset = CGSize(width: 500, height: 0)
            currentIndex = max(currentIndex - 1, 0)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    self.offset = .zero
                }
            }
        }
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
   
    func resetCardPosition() {
        withAnimation {
            offset = .zero
        }
    }

    func getProgress() -> Double {
        return Double(currentIndex+1)/Double(showVocabularies.count)
    }
    
    @Published var stories: [Story] = []
    @Published var currentStoryIndex: Int = 0
    
    
    func handleDragChanged(gesture: DragGesture.Value) {
        offset = gesture.translation
    }
   
    func handleDragEnded(gesture: DragGesture.Value) {
        if gesture.translation.width < -100, currentIndex > 0 {
            performSwipeLeft()
        } else if gesture.translation.width >= 100, currentIndex < stories[currentIndex].flashcard.count-1 {
            performSwipeRight()
        } else {
            resetCardPosition()
        }
           
    }
    
    func loadStories() {
        // Locate the JSON file in the bundle
        guard let url = Bundle.main.url(forResource: "quizpage", withExtension: "json") else {
            print("File not found")
            return
        }
       
        do {
            // Load and decode the JSON data
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.stories = try decoder.decode([Story].self, from: data)
            //print(self.stories)
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
    
    func loadVocabulary(from fileName: String) -> [Vocabulary]? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("File not found: \(fileName)")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Vocabulary].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
}

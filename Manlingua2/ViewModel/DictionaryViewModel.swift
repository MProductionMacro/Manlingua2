//
//  DictionaryViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import Foundation
import SwiftUI

class DictionaryViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var offset: CGSize = .zero
    @Published var checkResult: Bool = false
    @Published var isCheck: Bool = false
    @Published var flashcards: [Flashcard_Example] = []
    @Published var showFlashcards: [Flashcard_Example] = []
    @Published var showDonePage: Bool = false

    
    @Published var vocabularies: [Vocabulary] = []
    @Published var showVocabularies: [Vocabulary] = []
    
    init(){
        //loadVocabularies()
    }
    
    func loadVocabularies(storyId: Int, showFavoriteVocab: Bool){
        if showFavoriteVocab{
            loadFavoriteVocabularies()
        }
        else{
            loadStoryVocabularies(storyId: storyId)
        }
    }
    
    func loadFavoriteVocabularies(){
        vocabularies = []
        for vocab in SwiftDataServices.shared.vocabs{
            vocabularies.append(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning))
            print(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning))
        }

    }
    
    func loadStoryVocabularies(storyId: Int){
        
        for subIndex in 1..<4{
            var vocabulary = [Vocabulary]()
            guard let url = Bundle.main.url(forResource: "Kosakata\(storyId)_\(subIndex)", withExtension: "json") else {
                print("File not found: Kosakata\(String(describing: index))_\(subIndex)")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                vocabulary = try decoder.decode([Vocabulary].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
            self.vocabularies.append(contentsOf: vocabulary)
            print("Vocabularies: ")
            print(self.vocabularies)
        }
    }
    
    func loadAllVocabularies(){
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
        //showVocabularies = Array(vocabularies.prefix(10))
    }
}


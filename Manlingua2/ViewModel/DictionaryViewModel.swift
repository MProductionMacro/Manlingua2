//
//  DictionaryViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import Foundation
import SwiftUI

class DictionaryViewModel: ObservableObject {
    @Published var vocabularies: [Vocabulary] = []
    
    func loadVocabularies(from displayMode: DictionaryDisplayMode) {
        switch displayMode {
        case .favorite:
            loadFavoriteVocabularies()
        case .story(let id):
            loadStoryVocabularies(storyId: id)
        }
    }
    
    private func loadFavoriteVocabularies() {
        vocabularies = []
        for vocab in SwiftDataServices.shared.vocabs{
            vocabularies.append(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning))
            print(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning))
        }
    }
    
    private func loadStoryVocabularies(storyId: Int) {
        vocabularies = []
        for subIndex in 1...3 {
            loadVocabulary(from: storyId, subIndex: subIndex)
        }
    }
    
    private func loadVocabulary(from storyId: Int, subIndex: Int) {
        guard let url = Bundle.main.url(forResource: "Kosakata\(storyId)_\(subIndex)", withExtension: "json") else {
            print("Error: File 'Kosakata\(storyId)_\(subIndex).json' not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let vocabulary = try decoder.decode([Vocabulary].self, from: data)
            vocabularies.append(contentsOf: vocabulary)
        } catch {
            print("Error decoding JSON from 'Kosakata\(storyId)_\(subIndex).json': \(error.localizedDescription)")
        }
    }
}

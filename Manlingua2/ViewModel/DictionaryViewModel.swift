import Foundation
import SwiftUI

class DictionaryViewModel: ObservableObject {
    @Published public var vocabularies: [Vocabulary] = []
    @Published public var vocabularies_en: [Vocabulary] = []
    
   @MainActor public func loadVocabularies(from displayMode: DictionaryDisplayMode) {
        switch displayMode {
        case .favorite:
            loadFavoriteVocabularies()
        case .story(let id):
            loadStoryVocabularies(storyId: id)
        }
    }
    
    
    public func getNumberVocabularies()->Int{
        return max(vocabularies.count, vocabularies_en.count)
    }
    
    /*
   @MainActor private func loadFavoriteVocabularies() {
       if SwiftDataServices.shared.getLanguage() == .english{
            for vocab in SwiftDataServices.shared.vocabs_en{
                vocabularies.append(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning, hanziSentence: vocab.hanziSentence, pinyinSentence: vocab.pinyinSentence, meaningSentence: vocab.meaningSentence, language: vocab.language))
            }
        }
        else{
            for vocab in SwiftDataServices.shared.vocabs{
                vocabularies.append(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning, hanziSentence: vocab.hanziSentence, pinyinSentence: vocab.pinyinSentence, meaningSentence: vocab.meaningSentence, language: vocab.language))
            }
        }
    }
    */
    @MainActor private func loadFavoriteVocabularies() {
        if SwiftDataServices.shared.getLanguage() == .english{
             for vocab in SwiftDataServices.shared.getData(){
                 vocabularies_en.append(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning, hanziSentence: vocab.hanziSentence, pinyinSentence: vocab.pinyinSentence, meaningSentence: vocab.meaningSentence, language: vocab.language))
             }
         }
         else{
             for vocab in SwiftDataServices.shared.getData(){
                 vocabularies.append(Vocabulary(hanzi: vocab.hanzi, pinyin: vocab.pinyin, meaning: vocab.meaning, hanziSentence: vocab.hanziSentence, pinyinSentence: vocab.pinyinSentence, meaningSentence: vocab.meaningSentence, language: vocab.language))
             }
         }
     }
    
    
    private func loadStoryVocabularies(storyId: Int) {
        vocabularies = []
        for subIndex in 1...3 {
            loadVocabulary(from: storyId, subIndex: subIndex)
        }
    }
        
   @MainActor public func addVocabulary(_ vocab:Vocabulary){
        for i in 0..<vocabularies.count{
            if vocabularies[i].hanzi == vocab.hanzi{
                SwiftDataServices.shared.addData(vocabularies[i])
                SwiftDataServices.shared.addData(vocabularies_en[i])
                break
            }
        }
    }
    
    /*
    @MainActor public func getVocabulary(_ displayMode: DictionaryDisplayMode) -> [Vocabulary]{
        if displayMode == .favorite(isFromHome: true) || displayMode == .favorite(isFromHome: false) ||     SwiftDataServices.shared.getLanguage()  == .indonesian{
            return vocabularies
        }
        else{
            return vocabularies_en
        }
    }
     */
    @MainActor public func getVocabulary(_ displayMode: DictionaryDisplayMode) -> [Vocabulary]{
        if SwiftDataServices.shared.getLanguage()  == .indonesian{
            return vocabularies
        }
        else{
            return vocabularies_en
        }
    }
    
    public func isVocabsEmpty()->Bool{
        if vocabularies.isEmpty && vocabularies_en.isEmpty{
            return true
        }
        return false
    }
    
    private func loadVocabulary(from storyId: Int, subIndex: Int) {
        loadVocabularyId(storyId: storyId, subIndex: subIndex)
        loadVocabularyEn(storyId: storyId, subIndex: subIndex)
    }
    
    private func loadVocabularyId(storyId: Int, subIndex: Int){
        guard let url = Bundle.main.url(forResource: "Kosakata\(storyId)_\(subIndex)_id", withExtension: "json") else {
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
    
    private func loadVocabularyEn(storyId: Int, subIndex: Int){
        guard let url = Bundle.main.url(forResource: "Kosakata\(storyId)_\(subIndex)_en", withExtension: "json") else {
            print("Error: File 'Kosakata\(storyId)_\(subIndex).json' not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let vocabulary = try decoder.decode([Vocabulary].self, from: data)
            vocabularies_en.append(contentsOf: vocabulary)
        } catch {
            print("Error decoding JSON from 'Kosakata\(storyId)_\(subIndex).json': \(error.localizedDescription)")
        }
    }
}

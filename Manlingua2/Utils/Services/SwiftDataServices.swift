//
//  SwiftDataServices.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import Foundation
import SwiftData

class SwiftDataServices: ObservableObject {
    private let container: ModelContainer
    
    let context: ModelContext
    
    @MainActor
    static let shared = SwiftDataServices()
    
    @Published var vocabs: [VocabularyModel] = []
    
    @MainActor
    init() {
        do {
            self.container = try ModelContainer(for: VocabularyModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            self.context = container.mainContext
            vocabs = self.getData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func isVocabExist(vocab: Vocabulary) -> Bool{
        for vocabulary in vocabs {
            if vocabulary.hanzi == vocab.hanzi {
                return true
            }
        }
        return false
    }
    
    // Fungsi untuk menambahkan data baru ke database
    func addData(_ data: Vocabulary) {
        // Menyisipkan (insert) data baru ke dalam konteks
        
        var vocab = VocabularyModel(vocab: data)
        context.insert(vocab)
        do {
            try context.save()
            self.getData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Fungsi untuk menghapus data dari database
    func deleteData(_ data: Vocabulary) {
        // Menghapus data dari konteks
        for vocab in vocabs {
            if vocab.hanzi == data.hanzi {
                context.delete(vocab)
            }
        }
        do {
            try context.save()
            self.getData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteAll(){
        var vocabs = getData()
        for vocab in vocabs {
            context.delete(vocab)
        }
        self.getData()
        vocabs = []
    }
    
    func getData() -> [VocabularyModel] {
        do {
            vocabs = try context.fetch(FetchDescriptor<VocabularyModel>())
            return vocabs
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

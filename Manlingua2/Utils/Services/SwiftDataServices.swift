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
    @Published var notes: [ImportantNoteModel] = []
    
    
    @Published var vocabs_en: [VocabularyModel] = []
    @Published var notes_en: [ImportantNoteModel] = []
    
    @MainActor
    init() {
        do {
            self.container = try ModelContainer(for: VocabularyModel.self, ImportantNoteModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            self.context = container.mainContext
            _ = self.getData()
            _ = self.getNotes()
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
        
        let vocab = VocabularyModel(vocab: data)
        context.insert(vocab)
        do {
            try context.save()
            _ = self.getData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Fungsi untuk menghapus data dari database
    func deleteData(_ data: Vocabulary) {
        // Menghapus data dari konteks
        for i in 0..<vocabs.count {
            if vocabs[i].hanzi == data.hanzi {
                context.delete(vocabs[i])
                context.delete(vocabs_en[i])
            }
        }
        
        do {
            try context.save()
            _ = self.getData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func getData() -> [VocabularyModel] {
        do {
            var vocabsAll = try context.fetch(FetchDescriptor<VocabularyModel>())
            
            self.vocabs = []
            self.vocabs_en = []
            
            for vocab in vocabsAll {
                if vocab.language == "en" {
                    vocabs_en.append(vocab)
                }
                else{
                    vocabs.append(vocab)
                }
            }
                    
            if UserDefaultSingleton.shared.language == "en"{
                return vocabs_en
            }
            else{
                return vocabs
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    
    //================================================================
    //Important Notes
    func isNoteExist(_ importantNote: ImportantNote) -> Bool{
        if UserDefaultSingleton.shared.language == "en"{
            for note in notes_en{
                if importantNote.title == note.title {
                    return true
                }
            }
            return false
        }
        else{
            for note in notes{
                if importantNote.title == note.title {
                    return true
                }
            }
            return false
        }
    }
    
    // Fungsi untuk menambahkan data baru ke database
    func addNote(_ importantNote: ImportantNote) {
        // Menyisipkan (insert) data baru ke dalam konteks
        
        let note = ImportantNoteModel(from: importantNote)
        context.insert(note)
        print("Add Note")
        do {
            try context.save()
            _ = self.getNotes()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Fungsi untuk menghapus data dari database
    func deleteNote(_ data: ImportantNote) {
        // Menghapus data dari konteks
        for i in 0..<notes.count {
            if notes[i].title == data.title {
                context.delete(notes[i])
                context.delete(notes_en[i])
            }
        }
        
        do {
            try context.save()
            _ = self.getNotes()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getNotes() -> [ImportantNoteModel] {
        do {
            var notesAll = try context.fetch(FetchDescriptor<ImportantNoteModel>())
            
            self.notes = []
            self.notes_en = []
            
            for note in notesAll {
                if note.language == "en" {
                    notes_en.append(note)
                }
                else{
                    notes.append(note)
                }
            }
                    
            if UserDefaultSingleton.shared.language == "en"{
                return notes_en
            }
            else{
                return notes
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
    }
}

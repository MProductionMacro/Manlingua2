//
//  ImportantNotesViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import Foundation

class ImportantNotesViewModel : ObservableObject {
   @Published public var notes: [ImportantNote] = []
   @Published public var notes_en: [ImportantNote] = []
   
   init(){
      //loadFavoriteNotes()
   }
   
   @MainActor
   func loadNotes(from displayMode: NoteDisplayMode) {
       self.notes = []
       self.notes_en = []
      switch displayMode {
      case .favorite:
         loadFavoriteNotes()
      case .subChapter(let storyId, let subChapterId):
         loadNoteData(storyId: storyId, subChapterId: subChapterId)
      }
   }
   
   public func getNotes() -> [ImportantNote]{
      if UserDefaultSingleton.shared.language == "id"{
         return notes
      }
      else{
         return notes_en
      }
   }
   
   @MainActor
   private func loadFavoriteNotes() {
       for note in SwiftDataServices.shared.notes_en{
          notes_en.append(ImportantNote(title: note.title, allowed: note.allowed, forbidden: note.forbidden, caution: note.caution, language: note.language))
       }
       
       for note in SwiftDataServices.shared.notes{
          notes.append(ImportantNote(title: note.title, allowed: note.allowed, forbidden: note.forbidden, caution: note.caution, language: note.language))
       }
   }
   
   private func loadNoteEn(storyId: Int, subChapterId: Int){
      // Ganti "StoryData" dengan nama file JSON Anda tanpa ekstensi
      guard let url = Bundle.main.url(forResource: "Note\(storyId)_\(subChapterId)_en", withExtension: "json") else {
         print("File StoryData.json tidak ditemukan.")
         return
      }
      
      do {
         // Ambil data dari file JSON
         let data = try Data(contentsOf: url)
         
         // Dekode data JSON ke model Story_Example
         let decoder = JSONDecoder()
         let note = try decoder.decode(ImportantNote.self, from: data)
         self.notes_en.append(note)
         
         print("Load Data...")
         print("Berhasil")
         
      } catch {
         print("Gagal memuat atau mendekode JSON: \(error)")
      }
   }
   
   private func loadNoteId(storyId: Int, subChapterId: Int){
      // Ganti "StoryData" dengan nama file JSON Anda tanpa ekstensi
      guard let url = Bundle.main.url(forResource: "Note\(storyId)_\(subChapterId)_id", withExtension: "json") else {
         print("File StoryData.json tidak ditemukan.")
         return
      }
      
      do {
         // Ambil data dari file JSON
         let data = try Data(contentsOf: url)
         
         // Dekode data JSON ke model Story_Example
         let decoder = JSONDecoder()
         let note = try decoder.decode(ImportantNote.self, from: data)
         self.notes.append(note)
         
         print("Load Data...")
         print("Berhasil")
         
      } catch {
         print("Gagal memuat atau mendekode JSON: \(error)")
      }
   }
   
   private func loadNoteData(storyId:Int, subChapterId: Int) {
      loadNoteEn(storyId: storyId, subChapterId: subChapterId)
      loadNoteId(storyId: storyId, subChapterId: subChapterId)
   }
   
   @MainActor
   public func addNotes(_ note: ImportantNote){
      for i in 0..<notes.count{
          if notes[i].title == note.title || notes_en[i].title == note.title{
            SwiftDataServices.shared.addNote(notes[i])
            SwiftDataServices.shared.addNote(notes_en[i])
            break
         }
      }
   }
}

//
//  SwiftDataServices.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import Foundation
import SwiftData
import SwiftUI
import PhotosUI



@MainActor
class SwiftDataServices: ObservableObject {
   private let container: ModelContainer
   
   let context: ModelContext
   
   //   @MainActor
   static let shared = SwiftDataServices()
   
   @Published var vocabs: [VocabularyModel] = []
   @Published var notes: [ImportantNoteModel] = []
   
   @Published var vocabs_en: [VocabularyModel] = []
   @Published var notes_en: [ImportantNoteModel] = []
   
   @Published var latestStory: Int = 0
   @Published var latestSubChapter: Int = 0
   @Published var language: Lang = .english
   @Published var storyProgress: [Int] = [1, 1, 1, 1]
   @Published var hasOpenFlashcard: Bool = false
   @Published var hasOpenStoryDetail: Bool = false
   
   @Published var tasks = [0, 0, 0]
   @Published var totalTasks = 0.0
   @Published var totalStars = 0
   @Published var streak = 0
   @Published var rank = 0
   
   @Published var profilePicture: Image = Image("ProfilePicture")  // To store the profile picture data
   @Published var username: String = "Jane Doe"
    
   //   @MainActor
    /*
   init() {
      do {
        self.container = try ModelContainer(for: VocabularyModel.self, ImportantNoteModel.self, Story_Progress.self, Goal_Progress.self, ProfilePicture.self, Username.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
         self.context = container.mainContext
         
         fetchStoryProgressData()
         fetchGoalProgressData()
         
         _ = self.getData()
         _ = self.getNotes()
          
         profilePicture = getProfilePicture()
         username = fetchUsername()
      } catch {
         fatalError(error.localizedDescription)
      }
   }
    */
    
    //   @MainActor
    private init() {
        do {
            self.container = try ModelContainer(for: VocabularyModel.self, ImportantNoteModel.self, Story_Progress.self, Goal_Progress.self, ProfilePicture.self, Username.self, Language.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            self.context = container.mainContext
            
            fetchStoryProgressData()
            fetchGoalProgressData()
            
            _ = self.getData()
            _ = self.getNotes()
            
            _ = getProfilePicture()
            username = fetchUsername()
            
            if let fetchedLanguage = try? context.fetch(FetchDescriptor<Language>()).first {
                self.language = fetchedLanguage.lang
            }
            else{
                let newLanguage = Language(lang: .english)
                context.insert(newLanguage)
                try? context.save()
            }
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func getLanguage()-> Lang{
        return self.language
    }
    
    public func setSelectedLanguage(lang: Lang){
        // Fetch existing username if any
        if let existingLanguage = try? context.fetch(FetchDescriptor<Language>()).first {
            // Update existing username
            existingLanguage.lang = lang
            self.language = lang
        } else {
            // Create a new username if none exists
            let newLanguage = Language(lang: lang)
            context.insert(newLanguage)
        }
        try? context.save()
    }
    
    
    
    // MARK: - Create/Update
    func updateUsername(newName: String) {
       // Fetch existing username if any
       if let existingUsername = try? context.fetch(FetchDescriptor<Username>()).first {
           // Update existing username
           existingUsername.username = newName
           self.username = newName
       } else {
           // Create a new username if none exists
           let newUsername = Username(username: newName)
           context.insert(newUsername)
           self.username = newUsername.username
       }
       try? context.save()
    }

    // MARK: - Read
    func fetchUsername() ->String{
        if let fetchedUsername = try? context.fetch(FetchDescriptor<Username>()).first {
            return fetchedUsername.username
        }
        else{
            return "Jane Doe"
        }
    }


    func getProfilePicture() -> Image {
       do {
          // Try to fetch the first profile picture from the context
          if let savedProfilePicture = try context.fetch(FetchDescriptor<ProfilePicture>()).first {
             // If a profile picture exists, convert it to UIImage and return as SwiftUI Image
             if let uiImage = UIImage(data: savedProfilePicture.imageData) {
                 self.profilePicture = Image(uiImage: uiImage)
                 print(profilePicture)
                 return profilePicture
             }
          }
       } catch {
          print("Error fetching profile picture: \(error)")
       }
       return Image("ProfilePicture")
    }

    // Function to update the profile picture when the user selects a new photo
    func updateProfilePicture(photo: PhotosPickerItem) {
       Task {
          do {
             // Load the selected photo data
             if let data = try await photo.loadTransferable(type: Data.self) {
                // Create a new ProfilePicture object with the new image data
                let newProfilePicture = ProfilePicture(imageData: data)
                
                // Save the new profile picture data to the context
                saveProfilePictureData(newProfilePicture: newProfilePicture)
             }
          } catch {
             print("Error updating profile picture: \(error)")
          }
       }
    }

    // MARK: Save Profile Picture to Model
    private func saveProfilePictureData(newProfilePicture: ProfilePicture) {
       do {
          // Check if a profile picture already exists in the database
          let existingProfilePicture = try context.fetch(FetchDescriptor<ProfilePicture>()).first
          
          if let existing = existingProfilePicture {
             // If a profile picture exists, update it with the new image data
             existing.imageData = newProfilePicture.imageData
          } else {
             // If no profile picture exists, insert a new one
             context.insert(newProfilePicture)
          }
           
          // Save the changes to the context
          try context.save()
          
           let existingProfilePicture2 = try context.fetch(FetchDescriptor<ProfilePicture>()).first
          
           
          // Update the published property to reflect the changes
          _ = getProfilePicture()
       } catch {
          print("Error saving profile picture data: \(error)")
       }
    }
        
       
   //MARK: Fetching method for Goal and Story Progress
   
   private func fetchGoalProgressData(){
      do {
         let progressData = try context.fetch(FetchDescriptor<Goal_Progress>()).first
         if let progressData = progressData {
            tasks[0] = progressData.task1
            tasks[1] = progressData.task2
            tasks[2] = progressData.task3
            totalTasks = progressData.totalTasks
            totalStars = progressData.totalStars
            streak = progressData.streak
            rank = progressData.rank
         } else {
            initializeGoalDefaultData()
         }
      } catch {
         print("Error fetching Story Progress data: \(error)")
         initializeGoalDefaultData()
      }
   }
   
   private func fetchStoryProgressData() {
      do {
         let progressData = try context.fetch(FetchDescriptor<Story_Progress>()).first
         if let progressData = progressData {
            latestStory = progressData.latestStory
            latestSubChapter = progressData.latestSubChapter
            storyProgress = [
               progressData.chapter1,
               progressData.chapter2,
               progressData.chapter3,
               progressData.chapter4
            ]
            hasOpenFlashcard = progressData.hasOpenFlashcard
            hasOpenStoryDetail = progressData.hasOpenStoryDetail
         } else {
            initializeStoryDefaultData()
         }
      } catch {
         print("Error fetching Story Progress data: \(error)")
         initializeStoryDefaultData()
      }
   }
   
   //MARK: Initialize Story and Goal progress
   
   private func initializeStoryDefaultData() {
      latestStory = 1
      latestSubChapter = 1
      storyProgress = [1, 1, 1, 1]
      hasOpenFlashcard = false
      hasOpenStoryDetail = false
      
      saveStoryProgressData()
   }
   
   func resetGoalProgressPerDay(){
      tasks = [0,0,0]
      totalTasks = 0
      
      saveGoalProgressData()
   }
   
   func initializeGoalDefaultData() {
      tasks = [0, 0, 0]
      totalStars = 0
      totalTasks = 0
      streak = 0
      rank = 0
      
      saveGoalProgressData()
   }
   //MARK: Save Goal and Story progress
   
   func saveGoalProgressData(){
      do {
         let progressData = try context.fetch(FetchDescriptor<Goal_Progress>()).first
         ?? Goal_Progress(task1: tasks[0], task2: tasks[1], task3: tasks[2], totalTasks: totalTasks, totalStars: totalStars, streak: streak, rank: rank)
         // Update progress values
         progressData.task1 = tasks[0]
         progressData.task2 = tasks[1]
         progressData.task3 = tasks[2]
         progressData.totalStars = totalStars
         progressData.totalTasks = totalTasks
         progressData.streak = streak
         progressData.rank = rank
         
         context.insert(progressData) // Ensure object is added to context if not already present
         try context.save()
      } catch {
         print("Error saving Goal Progress data: \(error)")
      }
   }
   
   private func saveStoryProgressData() {
      do {
         let progressData = try context.fetch(FetchDescriptor<Story_Progress>()).first
         ?? Story_Progress(chapter1: storyProgress[0],
                           chapter2: storyProgress[1],
                           chapter3: storyProgress[2],
                           chapter4: storyProgress[3],
                           latestStory: latestStory,
                           latestSubChapter: latestSubChapter,
                           hasOpenFlashcard: hasOpenFlashcard,
                           hasOpenStoryDetail: hasOpenStoryDetail)
         // Update progress values
         progressData.latestStory = latestStory
         progressData.latestSubChapter = latestSubChapter
         progressData.chapter1 = storyProgress[0]
         progressData.chapter2 = storyProgress[1]
         progressData.chapter3 = storyProgress[2]
         progressData.chapter4 = storyProgress[3]
         progressData.hasOpenFlashcard = hasOpenFlashcard
         progressData.hasOpenStoryDetail = hasOpenStoryDetail
         
         context.insert(progressData) // Ensure object is added to context if not already present
         try context.save()
      } catch {
         print("Error saving Story Progress data: \(error)")
      }
   }
   
   //MARK: Setter for Story progress
   
   func setLatestChapter() {
      latestStory = max(latestStory, 1)
      saveStoryProgressData()
   }
   
   func setLatestSubChapter() {
      latestSubChapter = max(latestSubChapter, 1)
      saveStoryProgressData()
   }
   
   func updateLatestSubChapter(for subChapterId: Int) {
      if subChapterId > 3 {
         updateLatestStory(for: latestStory + 1)
         latestSubChapter = 1
      } else {
         latestSubChapter = subChapterId
      }
      saveStoryProgressData()
   }
   
   func updateLatestStory(for chapterId: Int) {
      latestStory = chapterId
      saveStoryProgressData()
   }
   
   func setAllSpecificStoryProgress() {
      for (index, progress) in storyProgress.enumerated() where progress == 0 {
         storyProgress[index] = 1
      }
      saveStoryProgressData()
   }
   
   func updateSpecificStoryProgress(story: Int, subChapterProgress: Int) {
      if subChapterProgress >= storyProgress[story - 1] {
         storyProgress[story - 1] = subChapterProgress
         saveStoryProgressData()
      }
   }
   
   //MARK: Getter
   
   func getSpecificStoryProgress(storyId: Int) -> Int {
      return storyProgress[storyId - 1]
   }
   
   func hasNotOpenFlashcardPage() -> Bool {
      if !hasOpenFlashcard {
         hasOpenFlashcard = true
         saveStoryProgressData()
         return true
      }
      return false
   }
   
   //MARK: Boolean in the Story Progress
   
   func hasOpenStoryDetailPage() -> Bool {
      if !hasOpenStoryDetail {
         hasOpenStoryDetail = true
         saveStoryProgressData()
         return true
      }
      return false
   }
   
   //MARK: Vocabulary function
   
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
   
   //MARK: Important notes function
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
         if notes[i].title == data.title || notes_en[i].title == data.title{
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


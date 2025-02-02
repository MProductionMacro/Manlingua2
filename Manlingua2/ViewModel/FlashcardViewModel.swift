import Foundation
import SwiftUI

class FlashcardViewModel: ObservableObject {
    @Published public var currentIndex: Int = 0
    @Published public var currentIndexProgressBar: Int = 0
    @Published public var offset: CGSize = .zero
    @Published public var showMicrophone: Bool = true
    @Published public var showDonePage: Bool = false
    @Published public var vocabularies: [Vocabulary] = []
    @Published public var vocabularies_en: [Vocabulary] = []
    @Published public var vocab_indices: [Int] = []
    @Published public var showVocabularies: [Vocabulary] = []
    @Published public var apiResult = ""
    
    @Published public var isTransitioning: Bool = false
    
    @MainActor init(){
        loadVocabularies()
        reshuffleCards()
    }
    
    public func checkResult() -> Bool{
        return apiResult == vocabularies[currentIndex].hanzi
    }
    
    public func loadVocabularies() {
        for index in 1..<5 {
            for subIndex in 1..<4 {
                loadVocabularyEn(index: index, subIndex: subIndex)
                loadVocabularyId(index: index, subIndex: subIndex)
            }
        }
        
        for i in 0..<vocabularies.count {
            vocab_indices.append(i)
        }
    }
    
    
    private func loadVocabularyEn(index: Int, subIndex: Int){
        guard let url = Bundle.main.url(forResource: "Kosakata\(index)_\(subIndex)_en", withExtension: "json") else {
           print("Error: File 'Kosakata\(index)_\(subIndex)_en.json' not found.")
           return
        }
        
        do {
           let data = try Data(contentsOf: url)
           let vocabulary = try JSONDecoder().decode([Vocabulary].self, from: data)
           self.vocabularies_en.append(contentsOf: vocabulary)
        } catch {
           print("Error decoding JSON from 'Kosakata\(index)_\(subIndex)_en.json.json': \(error.localizedDescription)")
        }
    }
    
    private func loadVocabularyId(index: Int, subIndex: Int){
        guard let url = Bundle.main.url(forResource: "Kosakata\(index)_\(subIndex)_id", withExtension: "json") else {
           print("Error: File 'Kosakata\(index)_\(subIndex)_id.json' not found.")
           return
        }
        
        do {
           let data = try Data(contentsOf: url)
           let vocabulary = try JSONDecoder().decode([Vocabulary].self, from: data)
           self.vocabularies.append(contentsOf: vocabulary)
        } catch {
           print("Error decoding JSON from 'Kosakata\(index)_\(subIndex)_id.json.json': \(error.localizedDescription)")
        }
    }
    

    @MainActor public func reshuffleCards(limit: Int = 10) {
       let shuffled_indices = vocab_indices.indices.shuffled()
       //print(shuffled_indices)
       
       vocabularies = shuffled_indices.map { vocabularies[$0] }
       vocabularies_en = shuffled_indices.map { vocabularies_en[$0] }
       
       if SwiftDataServices.shared.getLanguage() == .english{
           showVocabularies = Array(vocabularies_en.prefix(limit))
       }
       else{
           showVocabularies = Array(vocabularies.prefix(limit))

       }
   }
    
   @MainActor public func addVocabulary(_ vocab:Vocabulary){
        for i in 0..<showVocabularies.count{
            if showVocabularies[i].hanzi == vocab.hanzi{
                SwiftDataServices.shared.addData(vocabularies[i])
                SwiftDataServices.shared.addData(vocabularies_en[i])
                break
            }
        }
    }
   
   
    public func checkAnswer(answer: String)->Bool{
        print(answer)
        print(showVocabularies[currentIndex].hanzi)
        return answer == showVocabularies[currentIndex].hanzi
    }
    
    @MainActor public func saveDailyProgress(){
        let now = Date()
        let calendar = Calendar.current
        let defaults = UserDefaults.standard
        
        // Retrieve last completion date or handle first launch
        if let lastDate = defaults.object(forKey: "lastCompletionDate") as? Date {
           // Not the first launch
           if !calendar.isDate(lastDate, inSameDayAs: now) {
              if let yesterday = calendar.date(byAdding: .day, value: -1, to: now),
                 calendar.isDate(lastDate, inSameDayAs: yesterday) {
                 // Last task was completed yesterday, increment streak
                  SwiftDataServices.shared.streak += 1
              } else {
                 // Streak broken, reset to 1
                  SwiftDataServices.shared.streak = 0
              }
              
              // Update last completion date
              defaults.set(now, forKey: "lastCompletionDate")
           }
        } else {
           // First launch: initialize streak and save the current date
            SwiftDataServices.shared.streak += 1
           defaults.set(now, forKey: "lastCompletionDate")
        }
        
        // Update task completion and total progress
        if SwiftDataServices.shared.tasks[1] < 1 {
            SwiftDataServices.shared.tasks[1] += 1
            SwiftDataServices.shared.totalTasks = Double(SwiftDataServices.shared.tasks.reduce(0, +)) / Double(SwiftDataServices.shared.tasks.count)
        }
        
        // Save updated progress
        SwiftDataServices.shared.saveGoalProgressData()
    }
    
   public func performSwipeRight() {
       
       //guard !isTransitioning else { return }

       
      guard currentIndex <= showVocabularies.count else {
         return
      }
      
      //showMicrophone = true
      
      //withAnimation {
          /*
         isTransitioning = true
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
             self.isTransitioning = false
         }
         
         showMicrophone = true
           */
          
         self.offset = CGSize(width: 500, height: 0)
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.offset = .zero
            if self.currentIndex == self.showVocabularies.count - 1{
               self.showDonePage = true
            }
            else {
                self.currentIndex = min(self.currentIndex + 1, self.vocabularies.count-1 )
                
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    withAnimation(.easeInOut(duration: 0.3)){
                        self.currentIndexProgressBar = self.currentIndex
                    }
                //}

            }
         }
      //}
   }
   
   public func createFlashcardView(for index: Int) -> some View {
       let flashcardView = FlashcardView(vocab: showVocabularies[index], width: 300, height: 400, viewModel: self)
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
   
   public func getProgress() -> Double {
      return Double(currentIndex+1)/Double(showVocabularies.count)
   }
}


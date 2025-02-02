import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
   @Published public var stories_example: [Story] = []

    init(){
      loadStories()
   }
   
    @MainActor public func loadStories() {
      // Locate the JSON file in the bundle
       guard let url = Bundle.main.url(forResource: "Story_Example_\(SwiftDataServices.shared.getLanguage().rawValue)", withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.stories_example = try decoder.decode([Story].self, from: data)
      } catch {
         print("Failed to decode JSON: \(error.localizedDescription)")
      }
   }
}

//
//  ChallengeViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import SwiftUI
import Combine

class ChallengeViewModel: ObservableObject {
   //   @Published var isPredicted = false
   @Published var objects: [String] = []
   @Published var errorMessage: String?
   @Published var predictions: [Prediction] = []
   
   @Published var isPredicted = false
   
   @Published var objects_example: [Object] = []
   
   @Published var remainHour: Int = 24 // Initial hours remaining
   @Published var remainMinutes: Int = 60
   
   @Published var chatResponse: String = ""
   @Published var chatPrompt: String = ""
   
   @ObservedObject var singleton = SwiftDataServices.shared
   
   private let calendar = Calendar.current
   
   private let userDefaults = UserDefaults.standard
   private let baseURL = "https://paullmich28-manlingua.hf.space"
   
   let ranks = UserRank.allCases
   
   static let shared = ChallengeViewModel()
   
   init(){
      fetchObjects()
   }
   
   func taskDone(index: Int){
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
               singleton.streak += 1
            } else {
               // Streak broken, reset to 1
               singleton.streak = 0
            }
            
            // Update last completion date
            defaults.set(now, forKey: "lastCompletionDate")
         }
      } else {
         // First launch: initialize streak and save the current date
         singleton.streak += 1
         defaults.set(now, forKey: "lastCompletionDate")
      }
      
      // Update task completion and total progress
      if singleton.tasks[index] < 1 {
         singleton.tasks[index] += 1
         singleton.totalTasks = Double(singleton.tasks.reduce(0, +)) / Double(singleton.tasks.count)
      }
      
      // Save updated progress
      singleton.saveGoalProgressData()
   }
   
   func addStars(){
      singleton.totalStars += 1
      singleton.rank += 1
      //      if singleton.totalStars == 5 {
      //         singleton.rank += 1
      //         singleton.totalStars = 0
      //      }
      
      singleton.saveGoalProgressData()
   }
   
   func setupHourlyTimer() {
      Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
         self.updateRemainHour()
      }
   }
   
   // Calculate the remaining hours until midnight and update the UI
   func updateRemainHour() {
      let now = Date()
      let midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
      let hoursUntilMidnight = calendar.dateComponents([.hour], from: now, to: midnight).hour ?? 0
      let minutesUntilMidnight = calendar.dateComponents([.minute], from: now, to: midnight).minute ?? 0
      
      // Update remainHour to reflect time left until midnight
      remainHour = hoursUntilMidnight
      remainMinutes = minutesUntilMidnight
      
      let lastResetDate = UserDefaults.standard.object(forKey: "lastResetDate") as? Date ?? Date.distantPast
      print(lastResetDate)
      
      if !calendar.isDate(lastResetDate, inSameDayAs: now) {
         UserDefaults.standard.set(now, forKey: "lastResetDate") // Update last reset date
         singleton.resetGoalProgressPerDay()
      }
   }
   
   private var cancellables = Set<AnyCancellable>()
   
   //MARK: Photo Challenge
   func predictImage(_ image: UIImage) {
      guard let url = URL(string: "\(baseURL)/predict") else { return }
      
      guard let imageData = image.jpegData(compressionQuality: 0.8) else {
         DispatchQueue.main.async {
            self.errorMessage = "Failed to convert image to data"
         }
         return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      let boundary = UUID().uuidString
      request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
      
      var httpBody = Data()
      httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
      httpBody.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
      httpBody.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
      httpBody.append(imageData)
      httpBody.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
      
      request.httpBody = httpBody
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         if let error = error {
            DispatchQueue.main.async {
               self.errorMessage = "Failed to predict image: \(error.localizedDescription)"
               print(self.errorMessage)
            }
            return
         }
         
         guard let data = data else {
            return
         }
         
         do {
            let decodedResponse = try JSONDecoder().decode(PredictionResponse.self, from: data)
            DispatchQueue.main.async {
               self.predictions = decodedResponse.predictions ?? [Prediction(class: "Not Detected", confidence: 100)]
               print(self.predictions)
               
               withAnimation{
                  self.isPredicted = true
               }
            }
         } catch {
            DispatchQueue.main.async {
               print(error.localizedDescription)
               withAnimation{
                  self.isPredicted = true
               }
               self.errorMessage = "Error decoding prediction response"
               print(self.errorMessage)
            }
         }
      }.resume()
   }
   
   //MARK: Photo Challenge
   func fetchObjects() {
      guard let url = URL(string: "\(baseURL)/get_objects") else { return }
      
      let config = URLSessionConfiguration.ephemeral
      config.waitsForConnectivity = true
      
      let session = URLSession(configuration: config)
      
      session.dataTask(with: url) { data, response, error in
         if let data = data {
            do {
               let decodedResponse = try JSONDecoder().decode(ObjectResponse.self, from: data)
               DispatchQueue.main.async {
                  self.objects_example = Array(decodedResponse.objects.values)
               }
            } catch {
               print("Error decoding objects: \(error)")
            }
         }
      }.resume()
   }
   
   //   func generateChat(prompt: String) {
   //      guard let url = URL(string: "http://10.60.62.153:8000/generate_chat"),
   //            let jsonData = try? JSONEncoder().encode(ChatRequest(prompt: prompt)) else { return }
   //
   //      var request = URLRequest(url: url)
   //      request.httpMethod = "POST"
   //      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
   //      request.httpBody = jsonData
   //
   //      URLSession.shared.dataTask(with: request) { data, response, error in
   //         if let data = data {
   //            do {
   //               let decodedResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
   //               DispatchQueue.main.async {
   //                  self.chatResponse = decodedResponse.response
   //                  print(self.chatResponse)
   //               }
   //            } catch {
   //               print("Error decoding chat response: \(error)")
   //            }
   //         }
   //      }.resume()
   //   }
   
}

struct ChatRequest: Codable {
   let prompt: String
}

struct ChatResponse: Codable {
   let response: String
}

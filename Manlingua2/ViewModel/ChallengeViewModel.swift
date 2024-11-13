//
//  ChallengeViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import SwiftUI
import Combine
import SystemConfiguration

//TODO: Fix Timer + Progress Bar di GoalPageView

class ChallengeViewModel: ObservableObject {
   @Published var isPredicted = false
   @Published var objects: [String] = []
   @Published var errorMessage: String?
   @Published var predictions: [Prediction] = []
   
   @Published var objects_example: [Object] = []
   @Published var randomized_object: Object? = nil
   
   @AppStorage("firstTaskProgress") var firstTask: Int = 0
   @AppStorage("secondTaskProgress") var secondTask: Int = 0
   @AppStorage("thirdTaskProgress") var thirdTask: Int = 0
   @AppStorage("streakCount") var streakCount: Int = 0
   @AppStorage("remainHour") var remainHour: Int = 12
   @AppStorage("totalDuration") var totalDuration: TimeInterval = 12 * 3600 // 12 hours in seconds
   @AppStorage("remainingTime") var remainingTime: TimeInterval = 12 * 3600
   
   private let userDefaults = UserDefaults.standard
   private let baseURL = "http://10.60.62.153:8000"
   
   static let shared = ChallengeViewModel()
   
   init(){
      fetchObjects()
   }
   
   var startTime: Date {
      get {
         // Retrieve stored date, or return the default value if not set
         if let date = userDefaults.object(forKey: "startTime") as? Date {
            return date
         } else {
            return Date() // Set a default date if it doesn't exist
         }
      }
      set {
         userDefaults.set(newValue, forKey: "startTime")
      }
   }
   
   private var cancellables = Set<AnyCancellable>()
   
   var totalTasks: Int { 3 }
   var completedTasks: Int {
      [firstTask, secondTask, thirdTask].filter { $0 >= 1 }.count
   }
   
   private var hourlyTimer: AnyCancellable?
   
   var isTimerExpired: Bool {
      // Calculate remaining time based on the current date
      let elapsedTime = Date().timeIntervalSince(startTime)
      remainingTime = totalDuration - elapsedTime
      
      // If the remaining time is less than or equal to 0, reset
      if remainingTime <= 0 {
         resetTasks()
         return true
      }
      return false
   }
   
   //MARK: Photo Challenge
   func predictImage(_ image: UIImage) {
      guard let url = URL(string: "\(baseURL)/predict") else { return }
      
      // Convert UIImage to JPEG data
      guard let imageData = image.jpegData(compressionQuality: 0.8) else {
         DispatchQueue.main.async {
            self.errorMessage = "Failed to convert image to data"
         }
         return
      }
      
      // Set up the request with multipart form data
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
            }
            return
         }
         
         guard let data = data else {
            print("Error disini")
            return
         }
         
         do {
            let decodedResponse = try JSONDecoder().decode(PredictionResponse.self, from: data)
            DispatchQueue.main.async {
               self.isPredicted = true
               self.predictions = decodedResponse.predictions
            }
         } catch {
            DispatchQueue.main.async {
               self.errorMessage = "Failed to parse prediction data"
            }
         }
      }.resume()
   }
   
   func startHourlyCountdown() {
      hourlyTimer?.cancel()
      
      hourlyTimer = Timer.publish(every: 3600, on: .main, in: .common)
         .autoconnect()
         .sink { [weak self] _ in
            guard let self = self else { return }
            
            if self.remainHour > 0 {
               self.remainHour -= 1
            } else {
               self.resetTasks()
            }
            
            self.saveDailyStreak()
         }
   }
   
   private func resetTasks() {
      firstTask = 0
      secondTask = 0
      thirdTask = 0
      remainHour = 12
      
      startTime = Date() // Reset start time
      remainingTime = totalDuration // Reset remaining time
   }
   
   private func saveDailyStreak() {
      if completedTasks == totalTasks {
         streakCount += 1
      } else {
         streakCount = 0
      }
   }
   
   func incrementTaskProgress(task: TaskType) {
      switch task {
      case .first:
         firstTask = min(firstTask + 1, 1)
      case .second:
         secondTask = min(secondTask + 1, 1)
      case .third:
         thirdTask = min(thirdTask + 1, 1)
      }
      
      if completedTasks == totalTasks {
         remainHour = 0  // Reset immediately if all tasks are done
      }
   }
   
   func checkElapsedTime() {
      // Check the elapsed time when the app launches or comes to the foreground
      let elapsedTime = Date().timeIntervalSince(startTime)
      remainHour = max(0, Int((3600 - elapsedTime) / 3600))
      
      // Notify user if the timer has expired
      if isTimerExpired {
         
      }
   }
   
   //MARK: Photo Challenge
   func fetchObjects() {
      guard let url = URL(string: "\(baseURL)/get_objects") else { return }
      
      URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
         if let error = error {
            DispatchQueue.main.async {
               self?.errorMessage = "Failed to fetch objects: \(error.localizedDescription)"
               print(self?.errorMessage ?? "Unknown error")
            }
            return
         }
         
         if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            guard let data = data else { return }
            
            do {
               let decodedResponse = try JSONDecoder().decode(ObjectResponse.self, from: data)
               let objectsArray = Array(decodedResponse.objects.values)
               
               DispatchQueue.main.async {
                  self?.objects_example = objectsArray
               }
            } catch {
               DispatchQueue.main.async {
                  self?.errorMessage = "Failed to parse object data: \(error.localizedDescription)"
                  print(self?.errorMessage ?? "Unknown parsing error")
               }
            }
         } else {
            DispatchQueue.main.async {
               self?.errorMessage = "Failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)"
               print(self?.errorMessage ?? "Unknown status code error")
            }
         }
      }.resume()
   }
   
   
   //   func fetchObjects() {
   //      // Replace with your FastAPI endpoint URL
   //      guard let url = URL(string: "\(baseURL)/get_objects") else { return }
   //
   //      URLSession.shared.dataTaskPublisher(for: url)
   //         .map { $0.data }
   //         .decode(type: ObjectResponse.self, decoder: JSONDecoder())
   //         .map { response in
   //            // Extract the objects dictionary and convert it to an array
   //            Array(response.objects.values)
   //         }
   //         .replaceError(with: [])  // In case of error, return an empty array
   //         .receive(on: DispatchQueue.main)
   //         .sink { [weak self] objects in
   //            print("Objects Fetched: \(objects.count)")
   //            self?.objects_example = objects
   //         }
   //         .store(in: &cancellables)
   //
   //      print(objects_example.count)
   //      randomizeObject()
   //   }
   
   func randomizeObject(){
      randomized_object = objects_example.randomElement()
   }
}

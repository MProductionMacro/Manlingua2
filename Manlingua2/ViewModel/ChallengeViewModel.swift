//
//  ChallengeViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import SwiftUI
import Combine

class ChallengeViewModel: ObservableObject {
   @Published var isPredicted = false
   @Published var objects: [String] = []
   @Published var errorMessage: String?
   @Published var predictions: [Prediction] = []
   
   @Published var objects_example: [Object] = []
   
   @Published var remainHour2: Int = 24 // Initial hours remaining
   @Published var remainMinutes: Int = 60
   
   @ObservedObject var singleton = CoreDataSingleton.shared
   
   private let calendar = Calendar.current
   
   private let userDefaults = UserDefaults.standard
   private let baseURL = "http://10.60.62.153:8000"
   
   static let shared = ChallengeViewModel()
   
   init(){
      fetchObjects()
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
      remainHour2 = hoursUntilMidnight
      remainMinutes = minutesUntilMidnight
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
}

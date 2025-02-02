import SwiftUI
import Combine

class AppStorageController: ObservableObject {
   @AppStorage("firstTaskProgress") var firstTask: Int = 0
   @AppStorage("secondTaskProgress") var secondTask: Int = 0
   @AppStorage("thirdTaskProgress") var thirdTask: Int = 0
   @AppStorage("streakCount") var streakCount: Int = 0
   @AppStorage("remainHour") var remainHour: Int = 12
   @AppStorage("totalDuration") var totalDuration: TimeInterval = 12 * 3600 // 12 hours in seconds
   @AppStorage("remainingTime") var remainingTime: TimeInterval = 12 * 3600
   
   private let userDefaults = UserDefaults.standard
   
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
   
   static let shared = AppStorageController()
   
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
}

// Enum to make task selection more readable
enum TaskType {
   case first
   case second
   case third
}

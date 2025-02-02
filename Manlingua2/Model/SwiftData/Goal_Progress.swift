import SwiftData
import SwiftUI

@Model
class Goal_Progress {
   public var task1: Int
   public var task2: Int
   public var task3: Int
   public var totalTasks: Double
   public var totalStars: Int
   public var streak: Int
   public var rank: Int
   
   init(task1: Int, task2: Int, task3: Int, totalTasks: Double, totalStars: Int, streak: Int, rank: Int) {
      self.task1 = task1
      self.task2 = task2
      self.task3 = task3
      self.totalTasks = totalTasks
      self.totalStars = totalStars
      self.streak = streak
      self.rank = rank
   }
}

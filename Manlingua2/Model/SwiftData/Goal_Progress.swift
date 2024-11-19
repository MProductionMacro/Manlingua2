//
//  Goal_Progress.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/11/24.
//

import SwiftData
import SwiftUI

@Model
class Goal_Progress {
   var task1: Int
   var task2: Int
   var task3: Int
   var totalTasks: Double
   var totalStars: Int
   var streak: Int
   
   init(task1: Int, task2: Int, task3: Int, totalTasks: Double, totalStars: Int, streak: Int) {
      self.task1 = task1
      self.task2 = task2
      self.task3 = task3
      self.totalTasks = totalTasks
      self.totalStars = totalStars
      self.streak = streak
   }
}

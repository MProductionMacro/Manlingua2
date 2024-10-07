//
//  TalkingAnimation.swift
//  Manlingua2
//
//  Created by Paulus Michael on 04/10/24.
//

import SwiftUI

class TalkingAnimation: ObservableObject, TalkingAnimationProtocol {
   @Published var isTalking = false
   private let animationInterval = 0.2
   
   func startTalking(duration: Double) {
      let totalIntervals = Int(duration / animationInterval)
      animate(intervalsLeft: totalIntervals)
   }
   
   private func animate(intervalsLeft: Int) {
      guard intervalsLeft > 0 else {
         isTalking = false
         return
      }
      
      isTalking.toggle()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + animationInterval) {
         self.animate(intervalsLeft: intervalsLeft - 1)
      }
   }
}

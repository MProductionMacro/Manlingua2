//
//  HomeViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
   @Published var currentStage: Stage = .open
   
   enum Stage {
      case open
      case home
      case story
      case dictionary
      case outlineStory
   }
   
   func switchStage(to stage: Stage) {
      currentStage = stage
      print(currentStage)
   }
   
   func navigateToJourney(router: Router){
      router.push(.journeyPage)
   }
}

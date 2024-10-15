//
//  Router.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

class Router: ObservableObject {
   @Published var path: [Screen] = [Screen.splashScreen]
   @Published var rootView: Screen = Screen.splashScreen
   
   
   // MARK: - Navigation Functions
   func push(_ screen: Screen) {
      path.append(screen)
   }
   
   func pushReplace(_ screen: Screen) {
      rootView = screen
      let lastIndex = path.endIndex - 1
      path[lastIndex] = screen
   }
   
   func pop() {
      path.removeLast()
   }
   
   func popToRoot() {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
         self.path.removeLast(self.path.count - 1)
      }
   }

   @ViewBuilder
   func build(_ screen: Screen) -> some View {
      switch screen {
      case .splashScreen:
         SplashScreenView()
            .navigationBarBackButtonHidden(true)
      case .mainScreen:
         TabPageView()
            .navigationBarBackButtonHidden(true)
      case .pinyinInisial:
         InitialView()
            .navigationBarBackButtonHidden(true)
      case .pinyinFinal:
         FinalView()
            .navigationBarBackButtonHidden(true)
      case .pinyinNada:
         ToneView2()
            .navigationBarBackButtonHidden(true)
      case .journeyPage:
          JourneyPageView()
            .navigationBarBackButtonHidden(true)
      case .storyPage:
         StoryDetailView()
            .navigationBarBackButtonHidden(true)
      case .dictionary:
         DictionaryView()
            .navigationBarBackButtonHidden(true)
      }
   }
}

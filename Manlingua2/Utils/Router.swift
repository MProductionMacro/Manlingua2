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
         PinyinInitView()
            .navigationBarBackButtonHidden(true)
      case .pinyinFinal:
         PinyinFinalView()
            .navigationBarBackButtonHidden(true)
      case .pinyinNada:
         PinyinNadaView()
            .navigationBarBackButtonHidden(true)
      case .journeyPage(let storyId):
          JourneyPageView(storyId: storyId)
            .navigationBarBackButtonHidden(true)
      case .storyPage(let chapterId, let subChapterId, let condition):
          StoryDetailView(chapterId: chapterId, subChapterId: subChapterId, isFromHome: condition)
            .navigationBarBackButtonHidden(true)
      case .dictionary(let judul, let storyId, let showFavoriteVocab):
          DictionaryView(judul: judul, storyId:storyId, showFavoriteVocab: showFavoriteVocab)
      case .flashcardPage:
          FlashcardPageView()
              .navigationBarBackButtonHidden(true)
      case .donePage(let currentPage, let currentPart):
         DonePageView(currentPage: currentPage, currentPart: currentPart)
            .navigationBarBackButtonHidden(true)
      }
   }
}
         
                         /*
                     case dictionary(judul:String, story: Int)
                     case .dictionary(var test):
                         DictionaryView()
                           .navigationBarBackButtonHidden(true)
                          */

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
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .pinyinFinal:
         PinyinFinalView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .pinyinNada:
         PinyinNadaView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .journeyPage(let storyId):
         JourneyPageView(storyId: storyId)
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .storyPage(let chapterId, let subChapterId):
         StoryDetailView(chapterId: chapterId, subChapterId: subChapterId)
            .navigationBarBackButtonHidden(true)
      case .loadingPage(let chapterId, let subChapterId):
         LoadingView(chapterId: chapterId, subChapterId: subChapterId)
            .navigationBarBackButtonHidden(true)
      case .dictionary(let judul, let displayMode):
         DictionaryView(judul: judul, displayMode: displayMode)
            .onBackSwipe(perform: {
               self.pop()
            })
      case .flashcardPage:
         FlashcardPageView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .donePage(let displayMode):
          DonePageView(displayMode: displayMode)
              .onBackSwipe(perform: {
                     self.pop()
                  })
              .navigationBarBackButtonHidden(true)
      case .photoChallenge:
         PhotoChallengeView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .cameraView:
         CameraView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .importantNote(let displayMode):
          ImportantNotesPageView(displayMode: displayMode)
              .navigationBarBackButtonHidden(true)
      case .languageSetting:
          LanguageSettingView()
              .navigationBarBackButtonHidden(true)
      case .notificationSetting:
          NotificationSettingView()
              .navigationBarBackButtonHidden(true)
      }
   }
}

enum Screen: Hashable {
   case splashScreen
   case mainScreen
   case pinyinInisial
   case pinyinFinal
   case pinyinNada
   case journeyPage(storyId: Int)
   case storyPage(chapterId: Int, subChapterId: Int)
   case loadingPage(chapterId: Int, subChapterId: Int)
   case dictionary(judul:String, displayMode: DictionaryDisplayMode)
   case donePage(displayMode : DonePageDisplayMode)
   case flashcardPage
   case photoChallenge
   case cameraView
   case languageSetting
   case importantNote(displayMode: NoteDisplayMode)
   case notificationSetting
}

/*
 case dictionary(judul:String, story: Int)
 case .dictionary(var test):
 DictionaryView()
 .navigationBarBackButtonHidden(true)
 */

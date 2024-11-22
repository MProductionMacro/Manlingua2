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
      case .loginScreen:
         LoginView()
            .navigationBarBackButtonHidden(true)
      case .comingSoon:
         ComingSoonView()
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
//      case .cameraView:
//         CameraView()
//            .navigationBarBackButtonHidden(true)
      case .journeyPage(let storyId):
         JourneyPageView(storyId: storyId)
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .storyPage(let chapterId, let subChapterId):
         StoryDetailView(chapterId: chapterId, subChapterId: subChapterId)
            .navigationBarBackButtonHidden(true)
      case .loadingPage(let screen):
         LoadingView(screen: screen)
            .navigationBarBackButtonHidden(true)
      case .dictionary(let judul, let displayMode):
         DictionaryView(judul: judul, displayMode: displayMode)
            .onBackSwipe(perform: {
               self.pop()
            })
      case .flashcardPage:
         FlashcardPageView()
            .navigationBarBackButtonHidden(true)
      case .donePage(let displayMode, let chapterId, let subChapterId):
         DonePageView(displayMode: displayMode, chapterId: chapterId, subChapterId: subChapterId)
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .photoChallenge:
         PhotoChallengeView()
            .navigationBarBackButtonHidden(true)
      case .importantNote(let displayMode):
         ImportantNotesPageView(displayMode: displayMode)
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .languageSetting:
         LanguageSettingView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .notificationSetting:
         NotificationSettingView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .ioTSetting:
         IoTSettingView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .detailIoTSetting:
         DetailIoTSettingView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      case .aiSimulation:
         AIAssistantView()
            .onBackSwipe(perform: {
               self.pop()
            })
            .navigationBarBackButtonHidden(true)
      }
   }
}

indirect enum Screen: Hashable {
   case splashScreen
   case loginScreen
   case comingSoon
   case mainScreen
   case pinyinInisial
   case pinyinFinal
   case pinyinNada
   case journeyPage(storyId: Int)
   case storyPage(chapterId: Int, subChapterId: Int)
   case loadingPage(screen: Screen)
   case dictionary(judul:String, displayMode: DictionaryDisplayMode)
   case donePage(displayMode : DonePageDisplayMode, chapterId: Int, subChapterId: Int)
   case flashcardPage
   case photoChallenge
//   case cameraView
   case languageSetting
   case importantNote(displayMode: NoteDisplayMode)
   case notificationSetting
   case ioTSetting
   case detailIoTSetting
   case aiSimulation
}

/*
 case dictionary(judul:String, story: Int)
 case .dictionary(var test):
 DictionaryView()
 .navigationBarBackButtonHidden(true)
 */

//
//  PrimaryButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct PrimaryButtonView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var homeVM: HomeViewModel
   var isDisabled: Bool = false
   
   var id: Int
    
   @State var subChapterProgress = 1
   @StateObject var singleton = UserDefaultSingleton.shared
    
    init(isDisabled: Bool, id: Int){
        self.isDisabled = isDisabled
        self.id = id
    }
   
   var body: some View {
      Button(action: {
          guard !isDisabled else {
              return
          }
          
//         let chapterId = UserDefaults.standard.integer(forKey: "currentChapter")
         
         //viewModel.loadProgressForChapter(id, subChapters: homeVM.stories_example[id - 1].subChapter)
          router.push(.storyPage(chapterId: id, subChapterId: singleton.getSpecificStoryProgress(storyId: id), isFromHome: true))
          /*
          if id < singleton.latestStory {
              //let subChapterId = StoryProgressManager.getSpecificStoryProgess(story: id)
              //print("subChapterId disini : \(subChapterId)")
              //router.push(.storyPage(chapterId: id, subChapterId: subChapterId, isFromHome: true))
              
              print("==Story \(id)")
              print("==Subchapter Progress : \(singleton.getSpecificStoryProgress(storyId: id))")
              
              router.push(.storyPage(chapterId: id, subChapterId: singleton.getSpecificStoryProgress(storyId: id), isFromHome: true))
          }
          else{
              //let subChapterId = StoryProgressManager.getLatestSubChapter()
              //print("subChapterId disini : \(subChapterId)")
              //router.push(.storyPage(chapterId: id, subChapterId: subChapterId, isFromHome: true))

              router.push(.storyPage(chapterId: id, subChapterId: singleton.latestSubChapter, isFromHome: true))

          }
           */
         //router.push(.storyPage(chapterId: id, isFromHome: true))
      }){
         Text("Mulai")
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(isDisabled ? Color(red: 0.7, green: 0.7, blue: 0.7) : Color.white)
            .font(.system(size: 20, weight: .bold))
            .background(isDisabled ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color.orange3)
            .clipShape(.rect(cornerRadius: 16))
      }
      .disabled(isDisabled)
      /*
      .onAppear{
          subChapterProgress = StoryProgressManager.getSpecificStoryProgress(story: id)
          print("Story \(id)")
          print("Subchapter Progress : \(StoryProgressManager.getSpecificStoryProgress(story: id))")
      }
      */
   }
}

#Preview {
    PrimaryButtonView(isDisabled : false, id: 1)
      .environmentObject(Router())
      .environmentObject(StoryViewModel())
      .environmentObject(HomeViewModel())
}

//#Preview {
//   PrimaryButtonView(id: 1)
//      .environmentObject(Router())
//      .environmentObject(StoryViewModel())
//      .environmentObject(HomeViewModel())
//}

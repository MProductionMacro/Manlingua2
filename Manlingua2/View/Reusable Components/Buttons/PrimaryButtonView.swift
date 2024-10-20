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
   
   var body: some View {
      Button(action: {
//         let chapterId = UserDefaults.standard.integer(forKey: "currentChapter")
         
         viewModel.loadProgressForChapter(id, subChapters: homeVM.stories_example[id - 1].subChapter)
         
         router.push(.storyPage)
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
   }
}

#Preview {
   PrimaryButtonView(id: 1)
      .environmentObject(Router())
      .environmentObject(StoryViewModel())
      .environmentObject(HomeViewModel())
}

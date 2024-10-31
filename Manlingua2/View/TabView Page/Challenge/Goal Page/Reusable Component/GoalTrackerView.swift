//
//  GoalListView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct GoalTrackerView : View {
   @EnvironmentObject var router: Router
   @StateObject var appStorageController = AppStorageController.shared
   
   var task: TaskType
   var image: String
   var height: CGFloat
   var doneTask: Int
   
   var body : some View {
      HStack{
         Spacer()
         
         Image("\(image)")
            .resizable()
            .frame(width: 40, height: height)
         
         Spacer()
         
         VStack(alignment: .leading) {
            Text("Selesaikan 1 tantangan foto")
               .font(Font.subJudul())
            ProgressView(value: Double(doneTask), total: 1)
               .progressViewStyle(CustomProgressViewStyle(
                  height: UIScreen.main.bounds.height * 0.02,
                  filledColor: .green2,
                  unfilledColor: .customLighterGray
               ))
         }
         .frame(width: 245)
         
         Spacer()
         
         Button(action: {
//            appStorageController.incrementTaskProgress(task: task)
            router.push(.photoChallenge)
         }) {
            Image(systemName: "chevron.right")
               .font(Font.bpmf())
               .foregroundStyle(.orange)
         }
         
         Spacer()
      }
      .frame(width: 355, height: 75)
      .background(.white)
   }
}

#Preview {
   GoalTrackerView(task: .first, image: "Koin Cina", height: 40, doneTask: 0)
      .environmentObject(Router())
}

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
    var doneTask: Int
   
    var body : some View {
        HStack{
            Spacer()
         
            Image("\(image)")
                .resizable()
                .frame(width: 40, height: 40)
         
            Spacer()
         
            VStack(alignment: .leading, spacing: 8) {
                Text("Selesaikan 1 tantangan foto")
                    .font(Font.normalText())
             
                HStack {
                    Image(systemName: "clock")
                        .foregroundStyle(.padlock)
                        .font(.normalText())
                    Text("\(appStorageController.remainHour) Menit")
                        .foregroundStyle(.padlock)
                        .font(.normalText())
                }
             
                ProgressView(value: Double(doneTask), total: 1)
                    .progressViewStyle(
                        CustomProgressViewStyle(
                  height: UIScreen.main.bounds.height * 0.02,
                  filledColor: .greenNormalActive,
                  unfilledColor: .progressBar
               ))
            }
            .frame(width: 233, height: 60)
         
            Spacer()
         
            Button(action: {
                router.push(.photoChallenge)
            }) {
                Image(systemName: "chevron.right")
                    .font(Font.button())
                    .foregroundStyle(.orangeDarkMode)
            }
         
            Spacer()
        }
        .frame(width: 355, height: 100)
        .background(.blankBackground)
    }
}

#Preview {
   GoalTrackerView(task: .first, image: "Koin Cina", doneTask: 0)
      .environmentObject(Router())
}

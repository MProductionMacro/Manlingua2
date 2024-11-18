//
//  GoalPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//
import SwiftUI

struct GoalPageView: View {
   @StateObject var singleton = SwiftDataServices.shared
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   @State private var lastResetDate: Date = Date() // Track last reset date
   
   var body: some View {
      ZStack {
         VStack(alignment: .center, spacing: 24) {
            VStack(spacing: 8) {
               Text("Peringkat")
                  .font(Font.judulBesar())
                  .foregroundStyle(.white)
               
               HStack(alignment: .center) {
                  Text("Perunggu")
                     .font(Font.subJudul())
                     .frame(width: 92, height: 35)
                     .foregroundColor(.orangeDarkMode)
                     .background(.wordListButtonBackground)
                     .cornerRadius(8)
                  
                  HStack(spacing: 4){
                     Image(systemName: "flame.fill")
                        .resizable()
                        .font(Font.subJudul())
                        .foregroundStyle(.orange)
                        .frame(width: 15, height: 17)
                     Text("12")
                        .font(Font.subJudul())
                        .foregroundStyle(.black)
                  }
                  .frame(width: 55, height: 33)
                  .background(.white)
                  .cornerRadius(12)
               }
               
               RatingStarView(numberOfStars: singleton.totalStars)
            }
            .padding(.horizontal)
            
            CompletionTrackerView()
               .frame(width: 353, height: 92)
               .background(.cardBackground)
               .cornerRadius(16)
            
            VStack(spacing: 16) {
               HStack {
                  Text("Selesaikan tugas dibawah!")
                     .foregroundStyle(.padlock)
                     .font(.subJudul())
                  
                  Spacer()
                  
                  HStack(spacing: 4) {
                     Image(systemName: "clock")
                        .foregroundStyle(.padlock)
                     Text("\(viewModel.remainHour) jam")
                        .foregroundStyle(.padlock)
                        .font(.normalText())
                  }
               }
               .padding([.top, .horizontal], 20)
               
               VStack(spacing: 2) {
                  GoalTrackerView(task: .first, image: "Emas Cina", doneTask: singleton.tasks[0])
                     .onTapGesture {
                        viewModel.taskDone(index: 0)
//                        router.push(.photoChallenge)
                     }
                  
                  GoalTrackerView(task: .second, image: "Koin Cina", doneTask: singleton.tasks[1])
                     .onTapGesture {
                        viewModel.taskDone(index: 1)
                     }
                  
                  GoalTrackerView(task: .third, image: "Emas Batang", doneTask: singleton.tasks[2])
                     .onTapGesture {
                        viewModel.taskDone(index: 2)
                     }
               }
               .background(Color.customLightGray)
               .cornerRadius(25)
               .overlay {
                  RoundedRectangle(cornerRadius: 25)
                     .stroke(.customLightGray, lineWidth: 2)
               }
               
               Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blankBackground)
            .cornerRadius(32, corners: [.topLeft, .topRight])
         }
         .ignoresSafeArea(edges: .bottom)
      }
      .background(
         Image("ProfilePage")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
      )
      .onAppear {
         // Update the remaining hours immediately on app launch
         viewModel.updateRemainHour()
         // Start the timer to update every minute while the app is open
         viewModel.setupHourlyTimer()
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
         // Update the remaining hours when the app comes back from background
         viewModel.updateRemainHour()
      }
   }
}



#Preview {
   GoalPageView()
      .environmentObject(Router())
      .environmentObject(ChallengeViewModel())
}

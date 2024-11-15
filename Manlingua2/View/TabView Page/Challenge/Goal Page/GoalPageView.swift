//
//  GoalPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//
import SwiftUI

struct GoalPageView: View {
   @StateObject var appStorageController = AppStorageController.shared
   @EnvironmentObject var router: Router
   @State private var remainHour: Int = 24 // Initial hours remaining
   @State private var lastResetDate: Date = Date() // Track last reset date
   private let calendar = Calendar.current
   
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
               
               RatingStarView(numberOfStars: 3)
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
                  
                  HStack {
                     Image(systemName: "clock")
                        .foregroundStyle(.padlock)
                     Text("sisa \(remainHour) jam")
                        .foregroundStyle(.padlock)
                        .font(.normalText())
                  }
               }
               .frame(width: 353)
               .padding(.top, 20)
               
               VStack(spacing: 2) {
                  GoalTrackerView(task: .first, image: "Emas Cina", doneTask: appStorageController.firstTask)
                     .onTapGesture {
                        router.push(.photoChallenge)
                     }
                  
                  GoalTrackerView(task: .second, image: "Koin Cina", doneTask: appStorageController.secondTask)
                  GoalTrackerView(task: .third, image: "Emas Batang", doneTask: appStorageController.thirdTask)
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
         updateRemainHour()
         // Start the timer to update every minute while the app is open
         setupHourlyTimer()
      }
      .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
         // Update the remaining hours when the app comes back from background
         updateRemainHour()
      }
   }
   
   private func setupHourlyTimer() {
      Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
         updateRemainHour()
      }
   }
   
   // Calculate the remaining hours until midnight and update the UI
   private func updateRemainHour() {
      let now = Date()
      let midnight = calendar.nextDate(after: now, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime)!
      let hoursUntilMidnight = calendar.dateComponents([.hour], from: now, to: midnight).hour ?? 0
      
      // Update remainHour to reflect time left until midnight
      remainHour = hoursUntilMidnight > 0 ? hoursUntilMidnight : 24
   }
}



#Preview {
   GoalPageView()
      .environmentObject(Router())
}

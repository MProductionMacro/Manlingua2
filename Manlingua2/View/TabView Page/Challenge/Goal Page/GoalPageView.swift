//
//  GoalPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//
import SwiftUI
import Charts

struct GoalPageView: View {
   @StateObject var appStorageController = AppStorageController.shared
   
   var body: some View {
      ZStack {
         VStack(alignment: .center, spacing: 24) {
            VStack(spacing: 4) {
               Text("Peringkat")
                  .font(Font.judulBesar())
                  .foregroundStyle(.white)
               
               HStack(alignment: .center) {
                  Text("Murid")
                     .font(Font.bold16())
                     .frame(width: 75, height: 27)
                     .foregroundColor(.orange)
                     .background(.customBeige)
                     .cornerRadius(12)
                  
                  HStack {
                     Image(systemName: "flame.fill")
                        .resizable()
                        .foregroundStyle(.orange)
                        .frame(width: 15, height: 17)
                     Text("12")
                        .font(Font.bold12())
                  }
                  .frame(width: 60, height: 25)
                  .background(.white)
                  .cornerRadius(12)
               }
               
               LevelIndexView()
            }
            .padding(.horizontal)
            
            CompletionTrackerView()
            
            VStack(spacing: 20) {
               HStack {
                  Text("Selesaikan tugas dibawah!")
                     .foregroundStyle(.customLightGray)
                     .font(.hanzi())
                  
                  Spacer()
                  
                  HStack {
                     Image(systemName: "clock.fill")
                        .foregroundStyle(.gray)
                     Text("\(appStorageController.remainHour) Hour")
                        .foregroundStyle(.gray)
                        .font(.hanzi())
                  }
               }
               .padding(.top, 20)
               .padding(.horizontal, 20)
               
               VStack(spacing: 2) {
                  GoalTrackerView(task: .first, image: "Emas Cina", height: 25, doneTask: appStorageController.firstTask)
                  GoalTrackerView(task: .second, image: "Koin Cina", height: 40, doneTask: appStorageController.secondTask)
                  GoalTrackerView(task: .third, image: "Emas Batang", height: 30, doneTask: appStorageController.thirdTask)
               }
               .background(Color.customLightGray)
               .cornerRadius(25)
               .overlay {
                  RoundedRectangle(cornerRadius: 25)
                     .stroke(.customLightGray, lineWidth: 2)
               }
               
               Spacer()
            }
            .frame(maxHeight: .infinity)
            .background(.white)
            .cornerRadius(32, corners: [.topLeft, .topRight])
         }
         .ignoresSafeArea(edges: .bottom)
      }
      .background(Image("ProfilePage"))
//      .onAppear {
//         appStorageController.startHourlyCountdown()
//      }
   }
}



#Preview {
   GoalPageView()
}

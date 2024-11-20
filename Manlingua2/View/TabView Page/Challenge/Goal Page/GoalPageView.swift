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
   @EnvironmentObject var storyVM: StoryViewModel
   @State private var lastResetDate: Date = Date() // Track last reset date
   
   var body: some View {
      ZStack {
         VStack(alignment: .center, spacing: 16) {
            VStack(spacing: 8) {
               Text("Peringkat".localized)
                  .font(Font.judulBesar())
                  .foregroundStyle(.white)
               
               HStack(alignment: .center) {
                  Text(viewModel.ranks[singleton.rank].rawValue.localized)
                     .font(Font.subJudul())
                     .frame(width: 92, height: 35)
                     .foregroundColor(UserRankStyle.getTextColor(viewModel.ranks[singleton.rank]))
                     .background(UserRankStyle.getBackgroundColor(viewModel.ranks[singleton.rank]))
                     .cornerRadius(8)
                  
                  HStack(spacing: 4){
                     Image(systemName: "flame.fill")
                        .resizable()
                        .font(Font.subJudul())
                        .foregroundStyle(singleton.streak == 0 ? .customLightGray : .orange)
                        .frame(width: 15, height: 17)
                     Text("\(singleton.streak)")
                        .font(Font.subJudul())
                        .foregroundStyle(.black)
                  }
                  .frame(width: 55, height: 33)
                  .background(.white)
                  .cornerRadius(8)
               }
               
               RatingStarView(numberOfStars: singleton.totalStars)
            }
            .padding(.horizontal)
            
            if UIScreen.main.bounds.height>700{
               CompletionTrackerView()
                  .frame(width: 353, height: 92)
                  .background(.cardBackground)
                  .cornerRadius(16)
            }
            
            VStack(spacing: 16) {
               HStack {
                  Text("Selesaikan tugas dibawah!".localized)
                     .foregroundStyle(.padlock)
                     .font(.subJudul())
                  
                  Spacer()
                  
                  HStack(spacing: 4) {
                     Image(systemName: "clock")
                        .foregroundStyle(.padlock)
                     Text("\(viewModel.remainHour) jam".localized)
                        .foregroundStyle(.padlock)
                        .font(.normalText())
                  }
               }
               .padding([.top, .horizontal], 20)
               
               VStack(spacing: 2) {
                  GoalTrackerView(task: .first, image: "Emas Cina", challenge: "Selesaikan 1 subbab cerita".localized, doneTask: singleton.tasks[0]) {
                     viewModel.taskDone(index: 0)
                     storyVM.loadChat(storyId: singleton.latestStory, subChapterId: singleton.latestSubChapter)
                     router.push(.loadingPage(screen: .storyPage(chapterId: singleton.latestStory, subChapterId: singleton.latestSubChapter)))
                  }
                  
                  GoalTrackerView(task: .second, image: "Koin Cina", challenge: "Selesaikan 1 bagian flashcard".localized, doneTask: singleton.tasks[1]) {
                     viewModel.taskDone(index: 1)
                     router.push(.loadingPage(screen: .flashcardPage))
                  }
                  
                  GoalTrackerView(task: .third, image: "Emas Batang", challenge: "Selesaikan 1 tantangan foto".localized, doneTask: singleton.tasks[2]) {
                     viewModel.taskDone(index: 2)
                  }
               }
               .background(Color.customLightGray)
               .cornerRadius(25)
               .overlay {
                  RoundedRectangle(cornerRadius: 25)
                     .stroke(.customLightGray, lineWidth: 2)
               }
               //.padding(.horizontal, 24)
               
               
               Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blankBackground)
            .cornerRadius(32, corners: [.topLeft, .topRight])
         }
         .padding(.top)
         .ignoresSafeArea(edges: .bottom)
      }
      .background(
         Image("ProfilePage")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
      )
      .onAppear {
         //         print(Date.distantPast)
         viewModel.updateRemainHour()
         viewModel.setupHourlyTimer()
      }
      .onChange(of: singleton.tasks, { oldValue, newValue in
         if newValue.reduce(0, +) == 3 {
            viewModel.addStars()
         }
      })
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
      .environmentObject(StoryViewModel())
}

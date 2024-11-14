import SwiftUI

struct TabPageView: View {
   @State private var selectedTab = 0
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var learnVM: LearnViewModel
   
   var body: some View {
      CustomTabBarContainerView(selection: $selectedTab) {
         StoryListView()
            .tabBarItem(tab: TabBarItem(tag: 0, iconName: "house", title: "Belajar"), selection: $selectedTab)
         
         PinyinPageView()
            .tabBarItem(tab: TabBarItem(tag: 1, iconName: "lightbulb", title: "Intonasi"), selection: $selectedTab)
         
         GoalPageView()
            .tabBarItem(tab: TabBarItem(tag: 2, iconName: "dice", title: "Tantangan"), selection: $selectedTab)
         
         ProfilePageView()
            .tabBarItem(tab: TabBarItem(tag: 3, iconName: "person", title: "Profil"), selection: $selectedTab)
      }
   }
}


#Preview {
   TabPageView()
      .environmentObject(StoryViewModel())
      .environmentObject(HomeViewModel())
      .environmentObject(LearnViewModel())
      .environmentObject(Router())
   //      .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}

import SwiftUI

struct TabPageView: View {
   @State private var selectedTab = 0
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var learnVM: LearnViewModel
   
   var body: some View {
      TabView(selection: $selectedTab) {
         StoryListView()
            .tabItem {
               TabItemView(selectedTab: $selectedTab, text:"Belajar", image: "house", tag: 0)
            }
            .tag(0)
         
         PinyinPageView()
            .tabItem {
               TabItemView(selectedTab: $selectedTab, text:"Intonasi", image: "lightbulb", tag: 1)
            }
            .tag(1)
         
         GoalPageView()
            .tabItem {
               TabItemView(selectedTab: $selectedTab, text: "Challenge", image: "dice", tag: 2)
            }
            .tag(2)
         
         ProfilePageView()
            .tabItem {
               TabItemView(selectedTab: $selectedTab,  text:"Profile", image: "person", tag: 3)
            }
            .tag(3)
      }
      .onAppear{
         setTabViewAppearance()
      }
   }
   
   func setTabViewAppearance(){
      UITabBar.appearance().backgroundColor = UIColor.white
      
      let appearance = UITabBarAppearance()
      
      let selectedAttributes: [NSAttributedString.Key: Any] = [
         .foregroundColor: UIColor.darkGray,
         .font: UIFont.systemFont(ofSize: 12, weight: .bold)
      ]
      appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
      appearance.stackedLayoutAppearance.selected.iconColor = UIColor.orange3
      
      let normalAttributes: [NSAttributedString.Key: Any] = [
         .foregroundColor: UIColor.lightGray,
         .font: UIFont.systemFont(ofSize: 12)
      ]
      
      appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
      appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
      
      UITabBar.appearance().standardAppearance = appearance
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

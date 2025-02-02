import SwiftUI

extension View {
   func tabBarItem(tab: TabBarItem, selection: Binding<Int>) -> some View {
      self
         .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
   }
}

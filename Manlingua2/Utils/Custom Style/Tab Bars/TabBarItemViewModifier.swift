import SwiftUI

struct TabBarItemViewModifier: ViewModifier {
   let tab: TabBarItem
   @Binding var selection: Int
   
   public func body(content: Content) -> some View {
      content
         .opacity(selection == tab.tag ? 1.0 : 0.0)
         .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
   }
}

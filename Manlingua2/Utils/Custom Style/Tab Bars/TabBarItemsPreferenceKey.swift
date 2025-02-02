import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
   public static var defaultValue: [TabBarItem] = []
   
   public static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
      value += nextValue()
   }
}

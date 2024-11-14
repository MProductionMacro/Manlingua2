//
//  CustomTabBarContainerView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 14/11/24.
//

import SwiftUI

struct CustomTabBarContainerView<Content: View>: View {
   @Binding var selection: Int
   let content: Content
   @State private var tabs: [TabBarItem] = []
   
   init(selection: Binding<Int>, @ViewBuilder content: () -> Content){
      self._selection = selection
      self.content = content()
   }
   
   var body: some View {
      ZStack{
         ZStack{
            content
         }
         
         CustomTabView(tabs: tabs, selection: $selection)
            .frame(maxHeight: .infinity, alignment: .bottom)
      }
      .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
         self.tabs = value
      })
   }
}

struct TabBarItemViewModifier: ViewModifier {
   let tab: TabBarItem
   @Binding var selection: Int
   
   func body(content: Content) -> some View {
      content
         .opacity(selection == tab.tag ? 1.0 : 0.0)
         .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
   }
}

extension View {
   func tabBarItem(tab: TabBarItem, selection: Binding<Int>) -> some View {
      self
         .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
   }
}

struct TabBarItemsPreferenceKey: PreferenceKey {
   static var defaultValue: [TabBarItem] = []
   
   static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
      value += nextValue()
   }
}

//#Preview {
//    CustomTabBarContainerView()
//}

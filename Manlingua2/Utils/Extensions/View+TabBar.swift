//
//  View+TabBar.swift
//  Manlingua2
//
//  Created by Paulus Michael on 15/11/24.
//

import SwiftUI

extension View {
   func tabBarItem(tab: TabBarItem, selection: Binding<Int>) -> some View {
      self
         .modifier(TabBarItemViewModifier(tab: tab, selection: selection))
   }
}

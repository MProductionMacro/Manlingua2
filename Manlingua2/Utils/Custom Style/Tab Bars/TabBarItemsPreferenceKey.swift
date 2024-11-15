//
//  TabBarItemsPreferenceKey.swift
//  Manlingua2
//
//  Created by Paulus Michael on 15/11/24.
//

import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
   static var defaultValue: [TabBarItem] = []
   
   static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
      value += nextValue()
   }
}

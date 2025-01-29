//
//  TabBarItemsPreferenceKey.swift
//  Manlingua2
//
//  Created by Paulus Michael on 15/11/24.
//

import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
   public static var defaultValue: [TabBarItem] = []
   
   public static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
      value += nextValue()
   }
}

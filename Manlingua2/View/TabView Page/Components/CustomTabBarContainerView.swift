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

//#Preview {
//    CustomTabBarContainerView()
//}

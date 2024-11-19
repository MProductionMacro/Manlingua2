//
//  CustomTabView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 14/11/24.
//

import SwiftUI

struct CustomTabView: View {
   let tabs: [TabBarItem]
   @Binding var selection: Int
   
   var body: some View {
      VStack {
         Divider()
         
         HStack{
            ForEach(0..<tabs.count, id: \.self){ index in
               tabView(tab: tabs[index], index: index)
                  .onTapGesture {
                     switchToTab(index: index)
                  }
                  .tag(index)
            }
         }
         .padding(.horizontal)
      }
      .background(Color.blankBackground.ignoresSafeArea())
   }
}

extension CustomTabView {
   private func tabView(tab: TabBarItem, index: Int) -> some View {
      VStack(spacing: 2){
         Image(systemName: tab.iconName)
            .font(.button())
            .foregroundStyle(selection == index ? .orange3 : .gray)
         
         Text(tab.title)
            .font(.normalText())
            .foregroundStyle(selection == index ? .primary : Color.lightDarkGrey)
            .fontWeight(selection == index ? .bold : .regular)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 30)
      .padding(.top)
//      .background(selection == index ? .orange3.opacity(0.3) : .clear)
   }
   
   private func switchToTab(index: Int) {
      withAnimation(.easeInOut){
         selection = index
         
         
      }
   }
}


//
//  TabItemView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 26/10/24.
//

import SwiftUI

struct TabItemView: View {
   @Binding var selectedTab: Int
   var text: String
   var image: String
   var tag: Int
   
   var body : some View {
      Label {
         Text("\(text)")
            .fontWeight(selectedTab == tag ? .bold : .regular)
         //.foregroundStyle(selectedTab == 0 ? Color.orange3 : Color.clear)
      } icon: {
         Image(systemName: "\(image)")
            .renderingMode(.original)
            .foregroundStyle(.orange)
         //.foregroundStyle(selectedTab == 0 ? Color.orange3 :  Color.white)
      }
      .environment(\.symbolVariants, .none)
      
   }
}

#Preview {
   TabItemView(selectedTab: .constant(0), text: "Story", image: "Story", tag: 0)
}

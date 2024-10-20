//
//  DictionaryButtonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 01/10/24.
//

import SwiftUI

struct DictionaryButtonView: View {
   @EnvironmentObject var router: Router
   
   //TODO: Paddingnya
   var body: some View {
      Button(action: {
         //router.push(.dictionary)
      }) {
         HStack {
            Image("Flashcard")
            Text("Dictionary")
               .font(.system(size: 18, weight: .bold))
         }
         .padding(.vertical, 14.5)
         .padding(.horizontal, 16)
         .foregroundColor(.orange)
         .background(RoundedRectangle(cornerRadius: 12).fill(Color.gold2))
      }
      
   }
}

#Preview {
   DictionaryButtonView()
      .environmentObject(Router())
}

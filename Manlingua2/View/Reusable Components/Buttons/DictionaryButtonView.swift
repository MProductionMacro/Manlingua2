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
            Image("BookOpenText")
            Text("Dictionary".localized)
               .font(.button())
               .foregroundStyle(.orange3)
         }
         .padding()
         .foregroundColor(.orange)
         .background(.gold2)
         .clipShape(.rect(cornerRadius: 12))
      }
      
   }
}

#Preview {
   DictionaryButtonView()
      .environmentObject(Router())
}

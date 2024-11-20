//
//  ComingSoonView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 20/11/24.
//

import SwiftUI

struct ComingSoonView: View {
   @EnvironmentObject var router: Router
   
   var body: some View {
      VStack{
         Image(.orangeForBlank)
         Text("Coming Soon")
            .font(.judulBesar())
            .foregroundStyle(.white)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
         Image(.profilePage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
      )
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            Button(action:{
               router.pop()
            }){
               Image(systemName: "chevron.left")
                  .foregroundColor(.white)
                  .font(.semibold16())
                  .bold()
               
               Text("Kembali".localized)
                  .foregroundColor(.white)
                  .font(.semibold20())
                  .bold()
            }
         }
      }
   }
}

#Preview {
   NavigationView {
      ComingSoonView()
         .environmentObject(Router())
   }
}

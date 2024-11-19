//
//  PinYinCardView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//
import SwiftUI

struct PinYinCardView: View {
    @EnvironmentObject var router: Router 
   var body: some View {
      VStack {         
         HStack(alignment: .bottom) {
            VStack {
               HStack (alignment: .bottom){
                  Image("Inisial")
                  Image("FinalNada")
               }
               
                Text("Suku Kata".localized)
                  .bold()
            }
            .padding(.leading, 5)
            Spacer()
            
            VStack {
               Image("Karakter")
                  .padding(.bottom, 36)
                Text("Karakter".localized)
                  .bold()
            }
            .padding(.trailing, 5)
            
         }
      }
      .padding(.horizontal, 40)
      .padding(.vertical, 12)
      .background(.blankBackground)
      .clipShape(RoundedRectangle(cornerRadius: 24))
   }
}

#Preview{
   PinYinCardView()
}

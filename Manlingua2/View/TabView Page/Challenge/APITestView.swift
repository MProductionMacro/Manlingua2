//
//  APITestView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/10/24.
//

import SwiftUI

struct APITestView: View {
   @StateObject var viewModel = ChallengeViewModel()
   
   var body: some View {
      VStack{
         if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
         }else{
            ScrollView{
               ForEach(viewModel.objects, id: \.self) { object in
                  Text(object)
               }
            }
         }
      }
      .onAppear{
         viewModel.fetchObjects()
      }
   }
}

#Preview {
   APITestView()
}

//
//  CompletionTrackerView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct CompletionTrackerView: View{
   @StateObject var appStorageController = AppStorageController.shared
   
   var body: some View {
      VStack(alignment: .center) {
         VStack(alignment: .leading) {
            Text("Selesaikan 3 tugas")
               .font(Font.subJudul())
            
            ProgressView(
               value: Double(appStorageController.completedTasks),
               total: Double(appStorageController.totalTasks)
            )
            .progressViewStyle(CustomProgressViewStyle(
               height: UIScreen.main.bounds.height * 0.02,
               filledColor: .green2,
               unfilledColor: .customLighterGray
            ))
         }
         .frame(width: 334)
      }
      .frame(width: 355, height: 66)
      .background(.white)
      .cornerRadius(12)
   }
}

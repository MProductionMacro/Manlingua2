//
//  CompletionTrackerView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct CompletionTrackerView: View{
   @StateObject private var singleton = SwiftDataServices.shared
   @EnvironmentObject private var viewModel: ChallengeViewModel
   @EnvironmentObject private var router: Router
   var body: some View {
      VStack(alignment: .center) {
          VStack(alignment: .leading, spacing: 8) {
              Text("Selesaikan 3 tugas".localized)
               .font(Font.subJudul())
            
            ProgressView(
               value: Double(singleton.totalTasks),
               total: 1
            )
            .progressViewStyle(CustomProgressViewStyle(
                height: UIScreen.main.bounds.height * 0.02,
                filledColor: .greenNormalActive,
                unfilledColor: .progressBar
            ))
         }
         .frame(width: 321)
      }

   }
}

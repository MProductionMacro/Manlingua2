//
//  GoalListView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct GoalTrackerView : View {
    
    var image: String
    var height: CGFloat
    
    var doneTask: Int
    var totalTask: Int
    
    var body : some View {
        HStack{
            Spacer()
            Image("\(image)")
                .resizable()
                .frame(width: 40, height: height)
            Spacer()
            VStack(alignment: .leading){
                Text("Selesaikan 1 tantangan foto")
                    .font(Font.subJudul())
                CompletionBarView(width: 245, doneTask: doneTask, totalTask: totalTask)
            }
            .frame(width: 245)
            Spacer()
            Image(systemName : "chevron.right")
                .font(Font.bpmf())
                .foregroundStyle(.orange)
            Spacer()
        }
        .frame(width: 355, height: 75)
        .background(.white)
    }
}

#Preview {
    GoalTrackerView(image: "Koin Cina", height: 40, doneTask: 0, totalTask : 1)
}

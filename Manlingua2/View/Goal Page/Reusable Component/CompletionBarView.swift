//
//  CompletionTrackerView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct CompletionBarView : View {
    var width: CGFloat = 369
    var doneTask: Int
    var totalTask: Int
    
    var body : some View {
        HStack{
            Text("\(doneTask) / \(totalTask)")
                .foregroundStyle(.gray)
                .font(Font.subJudul())
        }
        .frame(width: width, height: 20)
        .background(.customLighterGray)
        .cornerRadius(8)
    }
}

#Preview{
    CompletionBarView(doneTask: 0, totalTask: 3)
}



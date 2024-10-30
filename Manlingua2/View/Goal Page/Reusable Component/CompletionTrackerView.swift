//
//  CompletionTrackerView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import SwiftUI

struct CompletionTrackerView: View{
    var firstTask: Int
    var secondTask: Int
    var thirdTask: Int
    
    var body : some View{
        VStack(alignment: .center){
            VStack(alignment: .leading){
                Text("Selesaikan 3 tugas")
                    .font(Font.subJudul())
                CompletionBarView(width: 334, doneTask: (firstTask + secondTask + thirdTask), totalTask: 3)
            }
            .frame(width: 334)
        }
        .frame(width: 355, height: 66)
        .background(.white)
        .cornerRadius(12)
    }

}

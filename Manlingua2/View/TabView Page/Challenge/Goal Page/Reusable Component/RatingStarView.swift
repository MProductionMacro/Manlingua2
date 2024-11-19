//
//  RatingStarView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 06/11/24.
//

import SwiftUI

struct RatingStarView : View {
    var numberOfStars: Int
    var body : some View {
        HStack{
            ForEach(0..<numberOfStars, id: \.self){ _ in
                Image(systemName: "star.fill")
                    .font(Font.titleKe2())
                    .fontWeight(.regular)
                    .foregroundColor(.greenNormalActive)
            }
            
            ForEach(numberOfStars..<5, id: \.self){ _ in
                Image(systemName: "star")
                    .font(Font.titleKe2())
                    .fontWeight(.regular)
                    .foregroundColor(.greenNormalActive)
            }
        }
    }
}

#Preview{
    RatingStarView(numberOfStars : 5)
}

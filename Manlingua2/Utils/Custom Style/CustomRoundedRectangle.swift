//
//  CustomRoundedRectangle.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct CustomRoundedRectangle: Shape {
   var cornerRadius: CGFloat
   var corners: UIRectCorner
   
   func path(in rect: CGRect) -> Path {
      let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
      return Path(path.cgPath)
   }
}

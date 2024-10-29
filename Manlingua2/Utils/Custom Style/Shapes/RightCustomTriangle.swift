//
//  RightCustomTriangle.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/10/24.
//

import SwiftUI

struct RightCustomTriangle: Shape {
   var cornerRadius: CGFloat
   
   func path(in rect: CGRect) -> Path {
      var path = Path()
      let width = rect.size.width
      let height = rect.size.height
      
      // Start at the top-left of the triangle
      path.move(to: CGPoint(x: 0, y: 0))
      
      // Draw the first line to the bottom-left corner of the triangle
      path.addLine(to: CGPoint(x: 0, y: height))
      
      // Draw the second line to the right corner
      path.addLine(to: CGPoint(x: width * 0.925, y: height * 0.6181))
      
      // Draw a curve to the top-right corner
      path.addCurve(to: CGPoint(x: width * 0.925, y: height * 0.38191),
                    control1: CGPoint(x: width * 1.025, y: height * 0.56561),
                    control2: CGPoint(x: width * 1.025, y: height * 0.43439))
      
      // Close the triangle
      path.addLine(to: CGPoint(x: 0, y: 0))
      path.closeSubpath()
      
      return path
   }
}

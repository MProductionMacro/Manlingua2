//
//  BubbleShape.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/10/24.
//

import SwiftUI

struct LeftCustomTriangle: Shape {
   var cornerRadius: CGFloat
   
   func path(in rect: CGRect) -> Path {
      var path = Path()
      let width = rect.size.width
      let height = rect.size.height
      
      //      path.move(to: CGPoint(x: 0.075*width, y: 0.38191*height))
      //
      //      path.addCurve(to: CGPoint(x: 0.075*width, y: 0.6181*height), control1: CGPoint(x: -0.025*width, y: 0.43439*height), control2: CGPoint(x: -0.025*width, y: 0.56561*height))
      //
      //      path.addLine(to: CGPoint(x: 0.75*width, y: 0.97238*height))
      //      path.addLine(to: CGPoint(x: 0.975*width, y: 0.14572*height))
      //      path.addLine(to: CGPoint(x: 0.075*width, y: 0.38191*height))
      
      path.move(to: CGPoint(x: 0.075*width, y: 0.38191*height))
      
      path.addCurve(to: CGPoint(x: 0.075*width, y: 0.6181*height), control1: CGPoint(x: -0.025*width, y: 0.43439*height), control2: CGPoint(x: -0.025*width, y: 0.56561*height))
      
      path.addLine(to: CGPoint(x: 1*width, y: 1*height))
      path.addLine(to: CGPoint(x: 1*width, y: 0*height))
      path.addLine(to: CGPoint(x: 0.075*width, y: 0.38191*height))
      
      path.closeSubpath()
      return path
   }
}

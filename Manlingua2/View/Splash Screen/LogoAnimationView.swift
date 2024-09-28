//
//  LogoAnimationView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct LogoAnimationView: View {
   @ObservedObject private var logoAnimation: LogoAnimation
   private let images: [String]
   
   init(images: [String], logoAnimation: LogoAnimation = LogoAnimation()) {
      self.images = images
      self.logoAnimation = logoAnimation
   }
   
   var body: some View {
      Image(images[logoAnimation.currentIndex])
         .resizable()
         .scaledToFit()
         .frame(width: 350, height: 350)
         .transition(.opacity)
         .animation(.none, value: logoAnimation.currentIndex)
   }
}

#Preview {
   LogoAnimationView(images: ["OrangeLeft", "OrangeRight", "OrangeMiddle"])
}

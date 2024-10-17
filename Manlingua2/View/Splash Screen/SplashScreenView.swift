//
//  SplashScreenView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct SplashScreenView: View {
   @StateObject private var logoAnimation = LogoAnimation()
   @EnvironmentObject var router: Router
   @State private var showTagline = false
   @State private var viewOpacity = 1.0
   
   var body: some View {
      ZStack {
         // Main screen is rendered behind the splash screen
         router.build(.mainScreen)
         
         ZStack{
            LinearGradient(
               stops: [
                  Gradient.Stop(color: Color(red: 1, green: 0.72, blue: 0.3), location: 0.00),
                  Gradient.Stop(color: Color(red: 1, green: 0.83, blue: 0), location: 1.00),
               ],
               startPoint: UnitPoint(x: 0.5, y: 0),
               endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
            
            VStack {
               LogoAnimationView(images: ["orangeLeft1", "orangeRight1", "orangeMiddle1"], logoAnimation: logoAnimation)
                  .onAppear {
                     logoAnimation.startIntroducing(duration: 2.8)
                  }
                  .onChange(of: logoAnimation.currentIndex) {
                     if logoAnimation.currentIndex == 2 {
                        withAnimation {
                           showTagline = true
                        }
                     }
                  }
               
               if showTagline {
                  Image("Tagline")
                     .resizable()
                     .scaleEffect(CGSize(width: 0.8, height: 0.8))
                     .scaledToFit()
                     .padding(.top, -200)
                     .frame(maxWidth: .infinity, maxHeight: 163, alignment: .center)
                     .transition(.opacity)
               }
            }
         }
         .opacity(viewOpacity)
      }
      .onAppear {
         DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeOut(duration: 0.5)) {
               viewOpacity = 0.0 // Fade out the splash screen
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               // After fade-out, push to the main screen
               router.pushReplace(.mainScreen)
            }
         }
      }
   }
}

#Preview {
   SplashScreenView()
      .environmentObject(Router())
      .environmentObject(HomeViewModel())
      .environmentObject(StoryViewModel())
      .environmentObject(LearnViewModel())
}

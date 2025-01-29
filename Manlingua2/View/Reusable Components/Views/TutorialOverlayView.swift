//
//  TutorialOverlayView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 15/10/24.
//

import SwiftUI

struct TutorialOverlayView: View {
   @Binding var tutorialOverlay: Int
   var width: CGFloat
   
   @State private var animateCircle = false
   
   var body: some View {
      VStack{
         if tutorialOverlay < 3 {
            Text("Lewati")
               .foregroundStyle(.white)
               .fontWeight(.semibold)
               .frame(maxWidth: .infinity, alignment: .trailing)
               .padding(.trailing)
               .onTapGesture {
                  tutorialOverlay += 2
               }
         }
         
         if tutorialOverlay == 1 {
            VStack {
               HStack {
                  ZStack {
                     // Hand icon
                     Image(systemName: "hand.point.up")
                        .font(.system(size: 48))
                        .foregroundStyle(.white)
                     
                     // Circle animation
                     Circle()
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        .scaleEffect(animateCircle ? 1 : 0.3) // Smaller initial and maximum scale
                        .opacity(animateCircle ? 0 : 1)
                        .animation(
                           Animation.easeOut(duration: 1)
                              .repeatForever(autoreverses: false),
                           value: animateCircle
                        )
                  }
                  
                  Text("Tekan bagian kiri untuk kebagian sebelumnya".localized)
                     .font(.subJudul())
                     .foregroundStyle(.white)
               }
               .frame(width: width)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .onTapGesture {
               tutorialOverlay += 1
            }
            
         }else if tutorialOverlay == 2 {
            VStack {
               HStack {
                  Text("Tekan bagian kanan untuk kebagian sebelumnya".localized)
                     .font(.subJudul())
                     .foregroundStyle(.white)
                  
                  ZStack {
                     // Hand icon
                     Image(systemName: "hand.point.up")
                        .font(.system(size: 48))
                        .foregroundStyle(.white)
                     
                     // Circle animation
                     Circle()
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        .scaleEffect(animateCircle ? 1.2 : 0.5) // Smaller initial and maximum scale
                        .opacity(animateCircle ? 0 : 1)
                        .animation(
                           Animation.easeOut(duration: 1)
                              .repeatForever(autoreverses: false),
                           value: animateCircle
                        )
                  }
               }
               .frame(width: width)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
            .onTapGesture {
               tutorialOverlay += 1
            }
         }
      }
      .background(.black.opacity(0.7))
      .onAppear {
         animateCircle = true
      }
   }
}

#Preview {
   TutorialOverlayView(tutorialOverlay: .constant(1), width: 1000)
}


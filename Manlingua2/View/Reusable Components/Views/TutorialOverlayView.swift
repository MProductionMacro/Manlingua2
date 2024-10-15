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
   
   var body: some View {
      if tutorialOverlay == 1 {
         VStack {
            HStack {
               Image(systemName: "hand.point.up")
                  .font(.system(size: 48))
                  .foregroundStyle(.white)
               
               Text("Tekan bagian kiri untuk kebagian sebelumnya")
                  .font(.subJudul())
                  .foregroundStyle(.white)
            }
            .frame(width: width)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
         .background(.black.opacity(0.5))
         .onTapGesture {
            tutorialOverlay += 1
         }
      }else if tutorialOverlay == 2 {
         VStack {
            HStack {
               Text("Tekan bagian kanan untuk kebagian sebelumnya")
                  .font(.subJudul())
                  .foregroundStyle(.white)
               
               Image(systemName: "hand.point.up")
                  .font(.system(size: 48))
                  .foregroundStyle(.white)
            }
            .frame(width: width)
         }
         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
         .background(.black.opacity(0.5))
         .onTapGesture {
            tutorialOverlay += 1
         }
      }
      
   }
}
//
//#Preview {
//   TutorialOverlayView(tutorialOverlay: .constant(1), width: 1000)
//}

//
//  CameraGrantedView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI

struct CameraGrantedView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   @StateObject var cameraController = CameraController.shared
   
   @State var image: UIImage = UIImage(resource: .placeholderChallenge)
   @State var isShowingMeaning = false
   
   var body: some View {
      ScrollView {
         if let randomObjects = viewModel.objects_example.randomElement(){
            VStack(spacing: 24){
               VStack(alignment: .leading, spacing: 8) {
                  Text("Cari dan fotokan")
                     .font(.judulBiasa())
                  
                  VStack(alignment: .leading) {
                     Text(randomObjects.pinyin)
                        .font(.pinyin())
                        .foregroundStyle(.gray)
                     Text(randomObjects.hanzi)
                        .font(.hanzi())
                        .overlay {
                           DottedUnderline()
                              .frame(height: UIScreen.main.bounds.height * 0.015)
                              .offset(y: UIScreen.main.bounds.height * 0.02)
                        }
                        .onTapGesture {
                           isShowingMeaning.toggle()
                        }
                        .popover(isPresented: $isShowingMeaning, attachmentAnchor: .point(.bottom)) {
                           ZStack {
                              Color.customLightGray
                                 .scaleEffect(1.5)
                              
                              Text(randomObjects.meaning)
                                 .font(.hanzi())
                                 .foregroundColor(.black)
                                 .padding(.horizontal, 4)
                                 .multilineTextAlignment(.leading)
                           }
                           .presentationCompactAdaptation(.popover)
                        }
                     
                  }
               }
               .frame(maxWidth: .infinity, alignment: .leading)
               
               VStack {
                  Button {
                     router.push(.cameraView)
                  } label: {
                     Image(systemName: "camera.fill")
                        .font(.system(size: 32))
                        .padding(8)
                  }
                  .buttonStyle(CircleButton())
               }
               .frame(maxWidth: .infinity)
               .padding(.vertical, UIScreen.main.bounds.height * 0.2)
               .background(.customLighterGray)
               .clipShape(.rect(cornerRadius: 35))
               .overlay(
                  RoundedRectangle(cornerRadius: 36)
                     .stroke(Color.gray, lineWidth: 2)
               )
               
               Button {
                  viewModel.objects_example.shuffle()
               } label: {
                  Text("Lewati")
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
               
//               ForEach(viewModel.predictions, id: \.self) { prediction in
//                  Text("\(prediction.class) : \(prediction.confidence)")
//               }
            }
         }
      }
      .padding(.horizontal)
      .padding(.top, 32)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .background(.white)
      .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
      .ignoresSafeArea()
      .overlay(content: {
         
         CorrectOrWrong(hanzi: "", pinyin: "", meaning: "", isCorrect: true) {
            
         } tryAgainFunc: {
            
         }
         .frame(maxHeight: .infinity, alignment: .bottom)
         .ignoresSafeArea()
      })
   }
}

#Preview {
   CameraGrantedView()
      .environmentObject(Router())
      .environmentObject(ChallengeViewModel())
}

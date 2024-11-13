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
   @State var isPredicted = false
   @State var isCorrect = false
   
   var body: some View {
      if let randomObjects = viewModel.objects_example.randomElement(){
         ScrollView {
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
               .padding(.top, UIScreen.main.bounds.height * 0.3)
               .padding(.bottom, UIScreen.main.bounds.height * 0.02)
               .background(.gray)
               .clipShape(.rect(cornerRadius: 16))
               .overlay(
                  RoundedRectangle(cornerRadius: 16)
                     .stroke(Color.gray.opacity(0.3), lineWidth: 2)
               )
               
               Button {
                  viewModel.objects_example.shuffle()
               } label: {
                  Text("Lewati")
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
            }
         }
         .padding(.horizontal)
         .padding(.top, 32)
         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
         .background(.blankBackground)
         .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
         .ignoresSafeArea()
         .overlay(content: {
            if isPredicted{
               CorrectOrWrong(hanzi: "", pinyin: "", meaning: "", isCorrect: isCorrect) {
                  isPredicted = false
                  viewModel.isPredicted = false
               } tryAgainFunc: {
                  isPredicted = false
                  viewModel.isPredicted = false
               }
               .frame(maxHeight: .infinity, alignment: .bottom)
               .ignoresSafeArea()
            }
         })
         .onChange(of: viewModel.isPredicted) { oldValue, newValue in
            if viewModel.isPredicted {
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                  isPredicted = true
                  isCorrect = viewModel.predictions.contains { prediction in
                     prediction.class == randomObjects.meaning
                  }
               }
            }
         }
      }
   }
}

#Preview {
   CameraGrantedView()
      .environmentObject(Router())
      .environmentObject(ChallengeViewModel())
}

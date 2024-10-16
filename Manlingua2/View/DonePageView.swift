//
//  DonePageView.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 16/10/24.
//

import SwiftUI


struct DonePageView: View {
    
    @State private var currentPage : DonePageString = .flashCard
    @State private var currentPart : PartOfTheStory = .first
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                Text(DonePageModel.title)
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding(12)
                Text(DonePageModel.description)
                    .font(.system(size: 20))
                
                Text(currentPage == .flashCard ? "Flashcard Harian" : currentPart.titleOfDescription )
                    .font(.system(size: 20))
                    .padding(.bottom, 60)

                Image(DonePageModel.imageName)
                    .frame(width: 335, height: 225)
                    .padding(.bottom, 50)
                
                Button (action: {
                    print("Button (Balik cerita) Pressed")
                }){
                    HStack {
                        Image(systemName: DonePageModel.bookSymbol)
                        Text(DonePageModel.returnToStoryTxt)
                            .font(.system(size: 20))
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(width: DonePageModel.buttonWidth, height: DonePageModel.buttonHeight)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.orange)
                    )
                }
                
                Button (action: {
                    print("Button (Ulangi) Pressed")
                }){
                    HStack {
                        Image(systemName: DonePageModel.returnSymbol)
                        Text("Ulangi \(currentPage.page)")
                            .font(.system(size: 20))

                    }
                    .foregroundStyle(Color.orange)
                    .padding()
                    .frame(width: DonePageModel.buttonWidth, height: DonePageModel.buttonHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.orange, lineWidth: 2)
                    )
                }
                
            }
        }
    }
}


#Preview {
    DonePageView()
}

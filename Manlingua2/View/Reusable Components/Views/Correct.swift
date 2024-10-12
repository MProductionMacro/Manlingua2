//
//  View.swift
//  HXD
//
//  Created by Ferdinand Jacques on 01/08/24.
//

import SwiftUI

struct Correct: View {
    var hanzi: String
    var pinyin: String
    var meaning: String
    @ObservedObject var viewModel: StoryViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.greenLight)
                .frame(width: .infinity, height: 289)
                .cornerRadius(24)
            VStack {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color.green2)
                        .font(.system(size: 24, weight: .bold))
                    Text("Correct!")
                        .foregroundStyle(Color.green2)
                        .font(.system(size: 24, weight: .bold))
                }
                .padding(.trailing, 220)
                .padding(.bottom, 10)
                HStack {
                    Text("\(hanzi) (\(pinyin)) means '\(meaning)'")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.black)
                        .padding(.bottom, 50)
                        .padding(.top, 10)
                }
                .frame(maxWidth: 350, alignment: .leading)
                Button(action: {
                    viewModel.moveToNextStage()
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.orange3)
                            .frame(width: 350, height: 64)
                            .cornerRadius(12)
                        Text("Continue")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
            }
        }
    }
}

#Preview {
    Correct(hanzi: "猫", pinyin: "Māo", meaning: "How many people", viewModel: StoryViewModel())
}

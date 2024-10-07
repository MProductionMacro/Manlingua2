//
//  TryAgainHanzi.swift
//  HXD
//
//  Created by Ferdinand Jacques on 09/08/24.
//

import SwiftUI

struct Wrong: View {
    var hanzi: String
    var pinyin: String
    var meaning: String
    @ObservedObject var viewModel: StoryViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.redLight)
                .frame(width: .infinity, height: 289)
                .cornerRadius(24)
            VStack {
                HStack {
                    Image(systemName: "cross.circle.fill")
                        .foregroundColor(Color.redNormal)
                        .font(.system(size: 24, weight: .bold))
                        .rotationEffect(.degrees(45))
                    Text("Oops!")
                        .foregroundStyle(Color.redNormal)
                        .font(.system(size: 24, weight: .bold))
                }
                .padding(.trailing, 255)
                .padding(.bottom, 20)
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Correct Answer:")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.black)
                        Text("\(hanzi)  |  \(pinyin)  |  \(meaning)")
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: 350, alignment: .leading)
                HStack(spacing: 16) {
                    Button(action: {
                        viewModel.quizView = "Quiz"
                        viewModel.quizView2 = "Quiz"
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(.redLight)
                                .frame(width: 64, height: 64)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.orange3, lineWidth: 3)
                                )
                            Image(systemName: "arrow.clockwise")
                                .foregroundStyle(Color.orange3)
                                .font(.system(size: 30, weight: .bold))
                                .rotationEffect(.degrees(45))
                        }
                    }
                    Button(action: {
                        viewModel.moveToNextStage()
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.orange3)
                                .frame(width: 280, height: 64)
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
}

#Preview {
    Wrong(hanzi: "猫", pinyin: "Māo", meaning: "Cat", viewModel: StoryViewModel())
}

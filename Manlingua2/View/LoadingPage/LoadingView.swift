//
//  LoadingView.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 29/10/24.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isLoading = true
    @State private var progressValue: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            
            Image("ChatBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Image("Animate")
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 70)
                VStack(spacing: 20) {
                    ProgressBar(progress: progressValue)
                        .frame(width: 300, height: 8)
                }
                Spacer()
            }
            .padding()
        }
        .onAppear {
            animateProgress()
        }
    }
    
    private func animateProgress() {
        withAnimation(.easeInOut(duration: 2.5)) {
            progressValue = 1.0
        }
    }
}

#Preview{
    LoadingView()
}

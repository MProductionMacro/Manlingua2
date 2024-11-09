//
//  MicrophoneView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 06/11/24.
//
import SwiftUI

struct MicrophoneView: View {
    var body : some View {
        HStack(alignment: .center){
            Image(systemName: "microphone.fill")
                .font(.judulBesar())
                .foregroundColor(.white)
                .frame(width: 84, height: 84)
                .background(Color.orange3)
                .clipShape(Circle())
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(.white)
    }
}

//
//  PinyinSoundCardView2.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//

import SwiftUI
import AVFoundation


struct PinyinSoundCardView2: View {
    var text: String
    var speak: String

    
    @State var angka = 0
    
    var body: some View {
        VStack(spacing: 10) {
            Text(text)
                .font(.system(size: 18))
                .foregroundStyle(.black)
         
            
            BubbleSoundButton(
                icon: "sound",
                buttonAction: {
                    let tts = TextToSpeech()

                    //tts.speakSlow(text: text)
                    /*
                    var audioPlayer : AVAudioPlayer!
                    do {
                        if let folderURL = Bundle.main.url(forResource: speak, withExtension: ".m4a"){
                            audioPlayer = try AVAudioPlayer(contentsOf: folderURL)
                            audioPlayer?.prepareToPlay()
                            audioPlayer?.play()
                            print("Playing sound.")
                            print(folderURL)
                        }

                    } catch let error {
                        print("Error initializing audio player: \(error.localizedDescription)")
                    }
                     */
                },
                size: 25,
                soundSize: 12
            )
        }
        //TODO: Size hard coded
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.customLightGray, lineWidth: 1)
        )
    }
}

/*
struct PinyinSoundCardView2: View {
    var text: String
    var speak: String

    var body: some View {
        VStack(spacing: 10) {
            Text(text)
                .font(.system(size: 18))
                .foregroundStyle(.black)
         
            
            BubbleSoundButton(
                icon: "sound",
                buttonAction: {
                    
                },
                size: 25,
                soundSize: 12
            )
        }
        //TODO: Size hard coded
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.customLightGray, lineWidth: 1)
        )
    }
}
*/
#Preview{
    PinyinSoundCardView2(text:"e", speak:"e")
}

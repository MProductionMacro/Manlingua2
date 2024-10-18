//
//  FlashcardTutorialOverlay.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 16/10/24.
//
import SwiftUI

struct FlashcardTutorialOverlay: View{
    @Binding var tutorialOverlay:Int 
    
    var body : some View{
        if tutorialOverlay == 1{
            ZStack{
                Button(action:{
                    //Langsung menghilangkan overlay kalau tombol "Lewati" diklik
                    tutorialOverlay = 3
                },label:{
                    Text("Lewati")
                        .font(Font.hanzi())
                        .foregroundColor(.white)
                })
                .offset(x:160, y:-390)
               HStack{
                    Text("Tekan untuk membuka menu kumpulan kata atau putar audio")
                        .font(.subJudul())
                        .foregroundStyle(.white)
                        
                    Image(systemName: "hand.point.up")
                        .font(.system(size: 48))
                        .foregroundStyle(.white)
                        .zIndex(1)
                }
                .frame(width: 300)
                .offset(x: 55, y: 220)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(.black.opacity(0.5))
        }
        else if tutorialOverlay == 2{
            ZStack{
                Button(action:{
                    //Langsung menghilangkan overlay kalau tombol "Lewati" diklik
                    tutorialOverlay = 3
                },label:{
                    Text("Lewati")
                        .font(Font.hanzi())
                        .foregroundColor(.white)
                })
                .offset(x:160, y:-390)
                HStack{
                    Text("Tekan lagi untuk tutup")
                        .font(.subJudul())
                        .foregroundStyle(.white)
                        
                    Image(systemName: "hand.point.up")
                        .font(.system(size: 48))
                        .foregroundStyle(.white)
                        .zIndex(1)
                }
                .frame(width: 145)
                .offset(x: -65, y: 220)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(.black.opacity(0.5))
        }
        

    }
}

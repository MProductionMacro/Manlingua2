//
//  DictionaryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 03/10/24.
//
import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var viewModel: StoryViewModel
    
    @StateObject var viewModel1 = DictionaryViewModel()
    var judul: String = "Perkenalan"
    var story: Int = 1
    var showFavoriteVocab: Bool = false
    
    init(judul:String, showFavoriteVocab: Bool){
        self.judul = judul
        self.showFavoriteVocab = showFavoriteVocab
    }
    
    init(judul:String, story: Int){
        self.judul = judul
        self.story = story
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.white)
            VStack {
                Text("\(judul)")
                //                 .font(Font.title())
                    .foregroundStyle(.black)
                    .padding(.top, 2)
                //            Text("Perkenalan")
                
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 16)
                    .foregroundColor(.black)
                
                Text("\(viewModel1.vocabularies.count) Kata")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 16)
                
                //TODO: Sizenya hard coded
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(viewModel1.vocabularies, id:\.self){
                            vocabulary in
                            
                            FlashcardDictionaryView(vocab: vocabulary)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                }
                .padding(.bottom, 15)

                
                //Spacer()
            }
            .navigationBarItems(leading: Button(action: {
                
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Kembali")
                }
                .foregroundColor(.orange)
            })
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear{
            //print(2)
            viewModel1.loadVocabularies(storyId: story, showFavoriteVocab: showFavoriteVocab)

        }
    }
}

#Preview {
    NavigationView{
        //DictionaryView(judul:"Perkenalan", story: 3)
        //.environmentObject(StoryViewModel())

        DictionaryView(judul:"Perkenalan", showFavoriteVocab: true)
           .environmentObject(StoryViewModel())
    }

}


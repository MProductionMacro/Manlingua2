//
//  LanguageSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct LanguageSettingView: View {
    @EnvironmentObject var router: Router
    @State var selectedId: Int = 1
    @State var lang: Language = .indonesian
    @StateObject var localizationManager: LocalizationManager = LocalizationManager.shared

    var body : some View {
        VStack{
            VStack(alignment: .leading, spacing: 16){
                Text("Pengaturan Bahasa".localized)
                    .font(.heavy32())
                    .padding(.bottom, -8)
                
                Text("Aplikasi akan beralih ke lingkungan bahasa yang Anda pilih".localized)
                    .font(.subJudul())
                    .opacity(0.65)
                
                LanguageSettingButton(image: .indonesianLogo, text: "Bahasa Indonesia".localized, selectionId: 1, selectedId: $selectedId){
                    selectedId = 1
                    lang = .indonesian
                }
                
                LanguageSettingButton(image: .englishLogo, text: "English".localized, selectionId: 2, selectedId: $selectedId){
                    selectedId = 2
                    lang = .english
                }
                
                
                Spacer()
                
                Button(action: {
                    UserDefaultSingleton.shared.setLanguage(language: lang)
                    if lang == .english {
                        
                        localizationManager.selectedLanguage = .english
                    }
                    else{
                        
                        localizationManager.selectedLanguage = .indonesian
                    }
                    router.popToRoot()
                }) {
                    Text("Simpan".localized)
                      .foregroundStyle(Color.white)
                      .font(.button())
                      .padding(20)
                      .frame(maxWidth: .infinity)
                      .background(.orangeDarkMode)
                      .clipShape(.rect(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, UIScreen.main.bounds.height < 700 ? -40 : 8)
            .padding(.bottom, UIScreen.main.bounds.height < 700 ? 8 : 0)

            //.padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blankBackground)
        .toolbar {
           ToolbarItem(placement: .topBarLeading) {
              HStack(alignment: .top){
                 Button(action:{
                    router.pop()
                 }){
                    Image(systemName: "chevron.left")
                       .foregroundColor(.orangeDarkMode)
                       .font(.title3)
                       .bold()
                    
                    Text("Kembali")
                       .foregroundColor(.orangeDarkMode)
                       .bold()
                 }
              }
           }
        }
        .onAppear{
            if UserDefaultSingleton.shared.language == "en"{
                selectedId = 2
            }
            else{
                selectedId = 1
            }
        }
    }
}

#Preview {
    NavigationView{
        LanguageSettingView()
            .environmentObject(Router())
    }
}




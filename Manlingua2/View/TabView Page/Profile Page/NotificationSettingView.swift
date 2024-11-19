//
//  NotificationSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/11/24.
//

import SwiftUI

struct NotificationSettingView: View {
    @EnvironmentObject var router: Router
    @State var selectedId: Int = 1
    @State var lang: Language = .indonesian

    var body : some View {
        VStack{
            
            VStack(alignment: .leading, spacing: 16){
                Text("Pengaturan Notifikasi".localized)
                    .font(.heavy32())
                    .padding(.bottom, -8)
                
                Text("Aplikasi akan beralih ke lingkungan bahasa yang Anda pilih".localized)
                    .font(.subJudul())
                    .opacity(0.65)
                
                Text("Aktifkan notifikasi melalui sistem pengaturan".localized)
                    .font(.subJudul())
                
                
                
                Spacer()
                
                Button(action: {
                    UserDefaultSingleton.shared.setLanguage(language: lang)
                    router.pop()
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
                    
                     Text("Kembali".localized)
                       .foregroundColor(.orangeDarkMode)
                       .bold()
                 }
              }
           }
        }
    }
}

#Preview {
    NavigationView{
        NotificationSettingView()
            .environmentObject(Router())
    }
}

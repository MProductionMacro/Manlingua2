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
                Text("Pengaturan Notifikasi")
                    .font(.heavy32())
                    .padding(.bottom, -8)
                
                Text("Aplikasi akan beralih ke lingkungan bahasa yang Anda pilih")
                    .font(.subJudul())
                    .opacity(0.65)
                
                Text("Aktifkan notifikasi melalui sistem pengaturan")
                    .font(.subJudul())
                
                
                
                Spacer()
                
                Button(action: {
                    UserDefaultSingleton.shared.setLanguage(language: lang)
                    router.pop()
                }) {
                   Text("Simpan")
                      .foregroundStyle(Color.white)
                      .font(.button())
                      .padding(20)
                      .frame(maxWidth: .infinity)
                      .background(.orangeDarkMode)
                      .clipShape(.rect(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
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
    }
}

#Preview {
    NavigationView{
        NotificationSettingView()
            .environmentObject(Router())
    }
}

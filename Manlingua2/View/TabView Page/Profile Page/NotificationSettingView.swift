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
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading, spacing: 16){
                    Text("Pengaturan Bahasa")
                        .font(.heavy32())
                    
                    Text("Aplikasi akan beralih ke lingkungan bahasa yang Anda pilih")
                        .font(.subJudul())
                        .opacity(0.65)
                    
                    Text("Aktifkan notifikasi melalui sistem pengaturan")
                        .font(.subJudul())

                }
                .padding(.top, 27)
                
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
                      .background(.orange3)
                      .clipShape(.rect(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .toolbar {
           ToolbarItem(placement: .topBarLeading) {
              HStack(alignment: .top){
                 Button(action:{
                    router.pop()
                 }){
                    Image(systemName: "chevron.left")
                       .foregroundColor(.orange3)
                       .font(.title3)
                       .bold()
                    
                    Text("Kembali")
                       .foregroundColor(.orange3)
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

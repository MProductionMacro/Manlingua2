//
//  NotificationSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/11/24.
//

import SwiftUI

struct NotificationSettingView: View {
    @EnvironmentObject var router: Router
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
    
    @State var selectedId: Int = 1
    
    var body : some View {
        VStack{
            Form {
                Section(header: Text("Notification Settings")) {
                    Button(action: {
                        openNotificationSettings()
                    }) {
                        HStack {
                            Text("Manage Notifications")
                            Spacer()
                            if notificationsEnabled {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
        }
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
    func openNotificationSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
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

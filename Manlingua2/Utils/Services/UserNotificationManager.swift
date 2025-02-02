import Foundation
import UserNotifications

class UserNotificationManager {
    // Singleton instance
    public static let shared = UserNotificationManager()
    
    // Private initializer untuk mencegah pembuatan instance baru
    private init() {}

    // Meminta izin notifikasi
    public func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Permission granted: \(granted)")
            }
        }
    }

    // Menjadwalkan notifikasi setiap menit pada detik ke-10
    public func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Manlingua"
        content.body = "Let's have fun with Mandarin!".localized
        content.sound = .default

        // Jadwalkan notifikasi setiap menit pada detik ke-10
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0
        dateComponents.second = 0
        /*
        dateComponents.hour = 10
        dateComponents.minute = 0
        dateComponents.second = 0
        */
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for every minute at second 10.")
            }
        }
    }
}



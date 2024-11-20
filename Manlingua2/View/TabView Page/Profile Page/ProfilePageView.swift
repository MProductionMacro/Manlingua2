import SwiftUI
import FirebaseAuth

struct ProfilePageView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image("ProfilePicture")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 5)
                VStack(alignment: .leading) {
                    Text(viewModel.name) // Use the dynamic name from ViewModel
                        .font(Font.titleKe2())
                        .foregroundColor(.white)
                        .padding(.bottom, 1)
                    Text(viewModel.getLevel())
                        .font(Font.subJudul())
                        .padding(.top, 1)
                        .foregroundColor(.userRank)
                }
                Spacer()
            }
            .frame(width: 361)
            .padding(.bottom, 17)
            .padding(.top, 30)
            
            VStack(spacing: 32) {
                VStack(spacing: 24) {
                    ProfileNavigationButton(title: "Bahasa", imageName: "globe") {
                        router.push(.languageSetting)
                    }
                    .frame(width: 361, height: 35)
                    
                    ProfileNavigationButton(title: "Notifikasi", imageName: "bell") {
                        router.push(.notificationSetting)
                    }
                    .frame(width: 361, height: 35)
                    
                    ProfileNavigationButton(title: "Perangkat Pintar", imageName: "externaldrive.connected.to.line.below") {
                        router.push(.ioTSetting)
                    }
                    .frame(width: 361, height: 35)
                }
                .frame(width: 393)
                .padding(.top, 24)
                
                Spacer()
                
                HStack {
                    Image(systemName: "door.left.hand.open")
                        .foregroundStyle(.orangeDarkMode)
                        .font(.semibold16())
                        .padding(.trailing, 10)
                    
                    Button(action: handleLogout) {
                        Text("Log Out")
                            .font(Font.semibold16())
                            .foregroundColor(.profileNavigationText)
                    }
                    
                    Spacer()
                    
                }
                .frame(width: 361, height: 35)
                .padding(.bottom, 80)
            }
            .frame(width: 401, height: 671)
            .background(.blankBackground)
            .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Image(.profilePage)
                .ignoresSafeArea()
                .scaledToFill()
        )
        .onAppear {
            viewModel.fetchUserName() // Fetch the user's name when the view appears
        }
    }
    func handleLogout() {
        do {
            try Auth.auth().signOut()
            router.pushReplace(.loginScreen) // Navigate back to the login page
        } catch let error {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProfilePageView()
        .environmentObject(Router())
}

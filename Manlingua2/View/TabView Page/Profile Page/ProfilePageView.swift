import SwiftUI
import FirebaseAuth

struct ProfilePageView: View {
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 0) {
                HStack{
                    Image("ProfilePicture")
                        .resizable()
                        .frame(width: 63, height: 63)
                        .padding(.trailing, 5)
                    VStack(alignment: .leading){
                       //FIXME: Nanti ganti lagi
                        Text("Abai")
                            .font(Font.titleKe2())
                            .foregroundColor(.white)
                            .padding(.bottom, 1)
                        Text("Perunggu")
                            .font(Font.subJudul())
                            .padding(.top, 1)
                            .foregroundColor(.userRank)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical)
                //.padding(.bottom, 17)
                
                VStack(spacing: 24) {
                    ProfileNavigationButton(title: "Bahasa".localized, imageName: "globe"){
                        router.push(.languageSetting)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .frame(height: 35)
                    .padding(.top, 24)
                  
                  
                    ProfileNavigationButton(title: "Notification".localized, imageName: "bell"){
                        router.push(.notificationSetting)
                    }
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                  
                    ProfileNavigationButton(title: "Perangkat Pintar".localized, imageName: "externaldrive.connected.to.line.below"){
                           router.push(.ioTSetting)
                    }
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
  
                    Spacer()
                    
                    HStack{
                        Image(systemName: "door.left.hand.open")
                            .foregroundStyle(.orangeDarkMode)
                            .font(.semibold16())
                            .padding(.trailing, 10)

                        /*
                            .resizable()
                            .foregroundStyle(.orange)
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 10)
                        */
                        Text("Log Out".localized)
                            .font(Font.semibold16())
                            .foregroundColor(.profileNavigationText)
                        Spacer()
                    }
                    .frame(height: 35)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 124)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blankBackground)
                .cornerRadius(32, corners: [.topLeft, .topRight])
            }
            .padding(.top)
            .ignoresSafeArea(edges: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
           Image("ProfilePage")
              .resizable()
              .scaledToFill()
              .ignoresSafeArea()
        )
    }
}


#Preview {
    ProfilePageView()
        .environmentObject(Router())
}

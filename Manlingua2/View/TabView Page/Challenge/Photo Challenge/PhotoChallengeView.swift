import SwiftUI

struct PhotoChallengeView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   @StateObject private var camera = CameraController.shared
   @State private var isCorrect = false
   
   @State private var isPredicted = false
   @State private var isShowingCamera = false
   @State private var isLoading = false
   
   var body: some View {
      ZStack {
         VStack(alignment: .leading) {
            Text("Tantangan Foto".localized)
               .font(.judulBesar())
               .foregroundStyle(.white)
               .padding()
            
            if camera.hasCameraPermission {
               CameraGrantedView(isShowingCamera: $isShowingCamera, isPredicted: $isPredicted, isLoading: $isLoading)
            } else {
               CameraNotGrantedView(primaryButtonPressed: {
                  print("Halo dunia")
                  //camera.requestPermission()
                   camera.allowCameraAccess()
                  //camera.requestPermission()
               }, secondaryButtonPressed: {
                  router.pop()
               })
            }
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .edgesIgnoringSafeArea(.bottom)
         .background(
            Image(.profilePage)
               .resizable()
               .scaledToFill()
               .ignoresSafeArea()
         )
         .padding(.top, UIScreen.main.bounds.height < 700 ? -40 : 8)
         .toolbar {
            if !isShowingCamera {
               ToolbarItem(placement: .topBarLeading) {
                  HStack(alignment: .top) {
                     Button(action: {
                        router.popToRoot()
                     }) {
                        Image(systemName: "chevron.left")
                           .foregroundColor(.white)
                           .font(.semibold16())
                        
                        Text("Kembali".localized)
                           .foregroundColor(.white)
                           .font(.semibold20())
                     }
                  }
               }
            }
         }
         
         if isLoading {
            ZStack {
               Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
               
               ProgressView("Loading...")
                  .progressViewStyle(CircularProgressViewStyle())
                  .scaleEffect(1.5, anchor: .center)
                  .font(.subJudul())
                  .foregroundColor(.white)
            }
         }
         
         // Show CameraView when isShowingCamera is true
         if isShowingCamera {
            CameraView(isShowingCamera: $isShowingCamera, isLoading: $isLoading)
               .transition(.move(edge: .bottom))
               .zIndex(1)
      
         }
      }
   }
}


#Preview {
   NavigationStack {
      PhotoChallengeView()
         .environmentObject(Router())
         .environmentObject(ChallengeViewModel())
   }
}

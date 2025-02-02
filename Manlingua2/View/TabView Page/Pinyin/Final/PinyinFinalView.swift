import SwiftUI

struct PinyinFinalView: View {
   @EnvironmentObject private var router: Router
   @StateObject private var viewModel = LearnViewModel()
   @State private var audioController = AudioController()
   
   var body : some View{
      ScrollView{
         VStack(spacing: 16){
             Text("Final".localized)
               .font(.system(size: 25, weight: .bold))
               //.padding(.top, 32 * 0.1)//(UIScreen.main.bounds.height / 852)
            
            Image("Final")
               .resizable()
               .scaledToFit()
               .frame(width:100, height: 100)
               .padding(.bottom, 16)
            
            VStack{
                Text("Tekan karakter untuk tahu cara".localized)
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
                Text("pengucapannya".localized)
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .leading, spacing: 12){
               ForEach(viewModel.getPinyinFinals(), id: \.self){ pinyins in
                  RowOfPinyinView(listPinyin: pinyins, audioController: $audioController)
               }
            }
             
            Spacer()
         }
         .ignoresSafeArea()
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .padding(.top, UIScreen.main.bounds.height < 700 ? -40 : 32)
          
         Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background( Color.blankBackground )
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            HStack(alignment: .top){
               Button(action:{
                  router.pop()
               }){
                   Image(systemName: "chevron.left")
                       .foregroundColor(.orangeDarkMode)
                       .font(.semibold16())
                       .bold()
               
                   Text("Kembali".localized)
                       .foregroundColor(.orangeDarkMode)
                       .font(.semibold20())
                       .bold()
               }
            }
         }
          
      }

   }
}

#Preview {
   NavigationView{
      PinyinFinalView()
         .environmentObject(Router())
   }
}

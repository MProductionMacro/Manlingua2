import SwiftUI

struct APITestView: View {
   @StateObject private var viewModel = ChallengeViewModel()
   
   var body: some View {
      VStack{
         if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
         }else{
            ScrollView{
               ForEach(viewModel.objects, id: \.self) { object in
                  Text(object)
               }
            }
         }
      }
      .onAppear{
         viewModel.fetchObjects()
      }
   }
}

#Preview {
   APITestView()
}

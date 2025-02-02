import SwiftUI

struct PinYinExampleCardView: View {
   var body: some View {
      VStack {
         HStack(alignment: .bottom) {
            VStack {
               HStack (alignment: .bottom){
                  Image("InisialNew")
                  Image("FinalNadaNew")
               }
               
               Text("Suku Kata")
                  .bold()
            }
            .padding(.leading, 5)
            Spacer()
            
            VStack {
               Image("KarakterNew")
                  .padding(.bottom, 36)
               Text("Karakter")
                  .bold()
            }
            .padding(.trailing, 5)
            
         }
      }
      .padding(.horizontal, 40)
      .padding(.vertical, 12)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 24))
   }
}

#Preview{
   PinYinExampleCardView()
}

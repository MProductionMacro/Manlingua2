import SwiftUI

struct Wrong: View {
   var hanzi: String
   var pinyin: String
   var meaning: String
   
   var continueFunc: () -> Void
   var tryAgainFunc: () -> Void
   
   var body: some View {
      VStack(alignment: .leading, spacing: 24) {
         VStack(alignment: .leading) {
            HStack(spacing: 12) {
               Button {
                  
               } label: {
                  Image(systemName: "waveform")
                     .foregroundStyle(.white)
                     .font(.judulBiasa())
                     .padding(12)
                     .background(.orange3)
                     .cornerRadius(16)
               }
               
               Image(systemName: "xmark.circle.fill")
                  .foregroundColor(.redNormal)
                  .font(.title)
               
               VStack(alignment: .leading) {
                  Text("hái cuò ,       zài   shì   yī    cì")
                     .foregroundStyle(.redNormal)
                     .font(.pinyin())
                     .fontWeight(.bold)
                  
                  Text("还错，再试一次")
                     .foregroundStyle(.redNormal)
                     .font(.judulBiasa())
               }
            }
            
            HStack {
                Text("\(hanzi) artinya \(meaning)".localized)
                  .foregroundStyle(.black)
                  .font(.subJudul())
            }
         }
         
         HStack(spacing: 16) {
            TryAgainButton(action: {
               tryAgainFunc()
            })
            
            ContinueButton(action: {
               continueFunc()
            })
         }
      }
      .edgesIgnoringSafeArea(.bottom)
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
      .padding(.top, 24)
      .padding(.bottom, 36)
      .background(.redLight)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
   }
}

#Preview {
   Wrong(hanzi: "Hello", pinyin: "Hello", meaning: "Hello", continueFunc: {}, tryAgainFunc: {})
}

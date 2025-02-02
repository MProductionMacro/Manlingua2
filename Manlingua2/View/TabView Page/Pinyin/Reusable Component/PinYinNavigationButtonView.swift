import SwiftUI

struct PinYinNavigationButton: View {
   @State var labelImage: ImageResource
   @State var title:String
   @State var content:String
   let action: () -> Void
   
   var body: some View {
      Button(action: {
         action()
      }, label: {
         HStack {
            HStack(spacing: 12) {
               Image(labelImage)
               VStack(alignment: .leading) {
                    Text(title.localized)
                      .font(.semibold20())
                      .fontWeight(.bold)
                    Text(content.localized)
                      .multilineTextAlignment(.leading)
                      .font(.normal16())
                      .frame(maxWidth: .infinity, alignment: .leading)
               }
               .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.fontColors)
            Image(systemName: "chevron.right")
               .foregroundStyle(.orange3)
               .fontWeight(.bold)
               .frame(width: 24, height: 24)
         }
         .padding()
         .overlay(
            RoundedRectangle(cornerRadius: 20)
               .stroke(.customLightGray, lineWidth: 1)
         )
      })
   }
}


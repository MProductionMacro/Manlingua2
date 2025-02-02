import SwiftUI

struct ProfileNavigationButton: View {
    
    var title: String
    var imageName: String
    var action: () -> Void // Fungsi sebagai parameter

    
    var body: some View{
        Button(action:{
            action()
        }, label: {
            HStack{
                Image(systemName: "\(imageName)")
                    .foregroundStyle(.orangeDarkMode)
                    .font(.semibold16())
                    .padding(.trailing, 10)
                //.resizable()
                    //.frame(width: 25, height: 25)

                Text("\(title)")
                    .font(Font.semibold16())
                    .foregroundColor(.profileNavigationText)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.orangeDarkMode)
                    .font(.semibold16())
                    //.padding(.trailing, 10)
                /*
                    .resizable()
                    .frame(width: 14, height: 25)
                 */
            }
        })

    }
}


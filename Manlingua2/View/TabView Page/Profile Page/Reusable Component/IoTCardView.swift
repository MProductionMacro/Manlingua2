import SwiftUI

struct IoTCardView : View {
    var body : some View {
        HStack(alignment: .center){
            Spacer()
            
            Image(systemName: "sensor.tag.radiowaves.forward.fill")
                .foregroundStyle(.orange)
                .font(Font.semibold20())
            
            Spacer()
            
            Text("Smart Speaker 1")
                .frame(width: 242, alignment: .leading)
                .font(Font.normal16())
            
            Spacer()
            
            Image(systemName: "power.circle.fill")
                .foregroundStyle(.greenNormalActive)
                .font(Font.semibold20())

            Spacer()
        }
        .frame(height: 78)
        .frame(maxWidth: .infinity)
        //.frame(width: 361, height: 78)
        .background(.cardBackground)
        .cornerRadius(8)
        .shadow(color: .cardShadow.opacity(0.15), radius: 5, x: 0, y: 0)
    }
}

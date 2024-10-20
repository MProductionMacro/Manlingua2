//
//  ProfilePageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 15/10/24.
//

import SwiftUI
import Charts

struct ProfilePageView: View {
    
    var name: String = "Aling"
    var level: String = "Murid Senior"
    
    let items = [
        SimpleItem(name: "Terjemah", unitsSold: 1),
        SimpleItem(name: "Dengar", unitsSold: 3),
        SimpleItem(name: "Ucap", unitsSold: 2),
        SimpleItem(name: "Obrol", unitsSold: 4)
    ]

    var body: some View {
        ZStack{
            //Color.orange.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Spacer()
                
                HStack{
                    Image("ProfilePicture")
                        .resizable()
                        .frame(width: 83.5, height: 83.5)
                        .padding(.trailing, 5)
                    VStack(alignment: .leading){
                        Text("\(name)")
                            .font(Font.judulBesar())
                            .foregroundColor(.white)
                        
                        Text("\(level)")
                            .font(Font.subJudul())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 15)
                
                VStack(spacing: 32){
                    
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("Penilaian")
                            .font(Font.judulBiasa())
                            .frame(width: 321, alignment: .leading)
                        
                        Chart(items, id: \.self){ item in
                            BarMark(
                                x: .value("Item", item.name),
                                y: .value("Units Sold", item.unitsSold)
                            )
                            .foregroundStyle(.green)
                        }
                        .frame(width: 300, height: 169)
   
                    }
                    .padding(.top, 32)
                    
                    VStack(spacing: 24){
                        ProfileNavigationButton(title: "Languages", imageName: "globe"){
                            
                        }
                        .frame(width: 321, height: 35)
                        
                        
                        ProfileNavigationButton(title: "Notification", imageName: "bell"){
                            
                        }
                        .frame(width: 321, height: 35)
                        
                        ProfileNavigationButton(title: "IoT", imageName: "externaldrive.connected.to.line.below"){
                            
                        }
                        .frame(width: 321, height: 35)
                        
                        ProfileNavigationButton(title: "Widget", imageName: "square.on.square"){
                            
                        }
                        .frame(width: 321, height: 35)
                    }
                    .frame(width: 321)
                        
 
                    
                    Spacer()
                }
                .frame(width: 401, height: 600)
                .background(.white)
                .cornerRadius(32, corners:[.topLeft, .topRight])

                //Spacer()
            }
        }
        .background(Image("ProfilePage"))
    }
}

#Preview {
    ProfilePageView()
}


struct SimpleItem: Hashable{
    let name: String
    let unitsSold: Int
}

struct RoundedCornersShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
}

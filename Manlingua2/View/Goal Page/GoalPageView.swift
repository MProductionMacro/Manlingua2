//
//  GoalPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//
import SwiftUI
import Charts

struct GoalPageView: View {
    var remainHour: Int
    var firstTask: Int
    var secondTask: Int
    var thirdTask: Int
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Spacer()
                
                VStack{
                    Text("Peringkat")
                        .font(Font.judulBesar())
                        .foregroundStyle(.white)
                        .padding(.bottom, -1)
                    
                    HStack(alignment: .center){
                        
                        Text("Murid")
                            .font(Font.bold16())
                            .frame(width: 75, height: 27)
                            .foregroundColor(.orange)
                            .background(.customBeige)
                            .cornerRadius(12)
                            
                        HStack{
                            Image(systemName: "flame.fill")
                                .resizable()
                                .foregroundStyle(.orange)
                                .frame(width: 15, height: 17)
                            Text("12")
                                .font(Font.bold12())
                        }
                        .frame(width: 60, height: 25)
                        .background(.white)
                        .cornerRadius(12)
                    }
                    .padding(.top, 2)
                    
                    LevelIndexView()
                        .padding(.bottom, 10)
                    
                    CompletionTrackerView(firstTask: firstTask, secondTask: secondTask, thirdTask: thirdTask)
                }
                .padding(.horizontal)
                .padding(.bottom, 15)
                .padding(.top, 25)
                
                VStack(spacing: 20){
                    HStack {
                        Text("Selesaikan tugas dibawah!")
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        
                        HStack{
                            Image(systemName: "clock.fill")
                                .foregroundStyle(.gray)
                            Text("\(remainHour) Hour")
                                .foregroundStyle(.gray)
                        }
                    }
                    .frame(width: 355, height: 17)
                    .padding(.top, 20)
                    
                    VStack(spacing: 2){
                        GoalTrackerView(image: "Emas Cina", height: 25, doneTask: firstTask, totalTask: 1)

                        GoalTrackerView(image: "Koin Cina", height: 40, doneTask: secondTask, totalTask: 1)
                        GoalTrackerView(image: "Emas Batang", height: 30, doneTask: thirdTask, totalTask: 1)
                    }
                    .background(Color.customLightGray)
                    .cornerRadius(25)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.customLightGray, lineWidth: 2)
                    }
                    
                    Spacer()
                }
                .frame(width: 401, height: 600)
                .background(.white)
                .cornerRadius(32, corners:[.topLeft, .topRight])
            }
        }
        .background(Image("ProfilePage"))
    }
}


#Preview {
    GoalPageView(remainHour: 12, firstTask: 1, secondTask: 1, thirdTask: 0)
}





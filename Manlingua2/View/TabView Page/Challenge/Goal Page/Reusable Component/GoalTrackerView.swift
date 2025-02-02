import SwiftUI

struct GoalTrackerView : View {
   @EnvironmentObject private var router: Router
   
   var task: TaskType
   var image: String
   var challenge: String
   var doneTask: Int
   var actionOnTapChevron: () -> Void
   
   var body : some View {
      HStack{
         Spacer()
         
         Image("\(image)")
            .resizable()
            .frame(width: 40, height: 40)
         
         Spacer()
         
         VStack(alignment: .leading, spacing: 8) {
             Text(challenge.localized)
               .font(Font.normalText())
            
            HStack {
               Image(systemName: "clock")
                  .foregroundStyle(.padlock)
                  .font(.normalText())
                Text("12 menit".localized)
                  .foregroundStyle(.padlock)
                  .font(.normalText())
            }
            
            ProgressView(value: Double(doneTask), total: 1)
               .progressViewStyle(
                  CustomProgressViewStyle(
                     height: UIScreen.main.bounds.height * 0.01,
                     filledColor: .greenNormalActive,
                     unfilledColor: .progressBar
                  ))
         }
         .frame(width: UIScreen.main.bounds.width - 160, height: 60)
         //353
          //- 40
          //- 120
         Spacer()
         
         Button(action: {
            actionOnTapChevron()
         }) {
            Image(systemName: "chevron.right")
         }
         .buttonStyle(ChevronRightButton())
         
         Spacer()
      }
      .frame(width: UIScreen.main.bounds.width - 40, height: 100)
      .background(.blankBackground)
   }
}

#Preview {
   GoalTrackerView(task: .first, image: "Koin Cina", challenge: "Selesaikan 1 kali salto", doneTask: 0, actionOnTapChevron: {
      
   })
      .environmentObject(Router())
}

/*
 struct GoalTrackerView : View {
    @EnvironmentObject var router: Router
    
    var task: TaskType
    var image: String
    var challenge: String
    var doneTask: Int
    var actionOnTapChevron: () -> Void
    
    var body : some View {
       HStack{
          Spacer()
          
          Image("\(image)")
             .resizable()
             .frame(width: 40, height: 40)
          
          Spacer()
          
          VStack(alignment: .leading, spacing: 8) {
              Text(challenge.localized)
                .font(Font.normalText())
             
             HStack {
                Image(systemName: "clock")
                   .foregroundStyle(.padlock)
                   .font(.normalText())
                 Text("12 menit".localized)
                   .foregroundStyle(.padlock)
                   .font(.normalText())
             }
             
             ProgressView(value: Double(doneTask), total: 1)
                .progressViewStyle(
                   CustomProgressViewStyle(
                      height: UIScreen.main.bounds.height * 0.01,
                      filledColor: .greenNormalActive,
                      unfilledColor: .progressBar
                   ))
          }
          .frame(height: 60)
          .frame(maxWidth: .infinity)
          //.frame(width: 233, height: 60)
          
          Spacer()
          
          Button(action: {
             actionOnTapChevron()
          }) {
             Image(systemName: "chevron.right")
                .font(Font.button())
                .foregroundStyle(.orangeDarkMode)
          }
          
          Spacer()
       }
       .frame(height: 100)
       .frame(maxWidth: .infinity)
       .background(.blankBackground)

       //.frame(width: 355, height: 100)
    }
 }

 */

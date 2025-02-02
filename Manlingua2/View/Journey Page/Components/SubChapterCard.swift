import SwiftUI


struct SubChapterButton : PrimitiveButtonStyle {
    @State var isLocked:Bool
    var id: Int
    var subChapter: SubChapter
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
           HStack(spacing: 12) {
              if isLocked {
                  Image(.newLock)
                    .resizable()
                    .frame(width: 86, height: 86)
              }
              else{
                  Image(.newHaidilao)
                    .resizable()
                    .frame(width: 86, height: 86)
              }
              
              VStack(alignment: .leading, spacing: 4) {
                 Text("Bagian".localized + " \(subChapter.id)")
                    .font(.pinyin())
                    .fontWeight(.bold)
                 Text(subChapter.title)
                    .font(.subJudul())
                 VStack(spacing: 0){
                    Text(subChapter.pinyin)
                       .multilineTextAlignment(.leading)
                       .font(.pinyin())
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .foregroundStyle(.emptyListText)
                    Text(subChapter.hanzi)
                       .multilineTextAlignment(.leading)
                       .font(.hanzi())
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .foregroundStyle(.emptyListText)
                 }
                 
                 HStack(spacing: 2){
                    Image(systemName: "clock")
                       .foregroundStyle(.emptyListText)
                       .font(.normalText())
                    
                    Text("sekitar 15 menit".localized)
                       .foregroundStyle(.emptyListText)
                       .font(.pinyin())
                 }
              }
              .frame(maxWidth: .infinity, alignment: .leading)
           }
           .frame(maxWidth: .infinity, alignment: .leading)
           
           Image(systemName: isLocked ? "lock" : "chevron.right")
                .foregroundStyle(isLocked ? .padlock : .orangeDarkMode)
                .fontWeight(.bold)
           
           Spacer()
        }
        .padding()
        .background(.cardBackground)
        .cornerRadius(20)
        .overlay(
           RoundedRectangle(cornerRadius: 20)
              .stroke(.customLightGray, lineWidth: 1)
        )
        .gesture(DragGesture(minimumDistance: 0).onChanged { _ in
        }.onEnded { value in
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.001){
              withAnimation {
                 configuration.trigger()
              }
           }
        })
    }
}



struct SubChapterCard: View {
   @State var labelImage: ImageResource
   @State var isLocked:Bool
   var id: Int
   var subChapter: SubChapter
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var journeyVM: JourneyViewModel
   @EnvironmentObject var homeVM: HomeViewModel
   @StateObject var singleton = SwiftDataServices.shared
   
   var body: some View {
      HStack {
         HStack(spacing: 12) {
            if isLocked {
                Image(.newLock)
                  .resizable()
                  .frame(width: 86, height: 86)
            }
            else{
                Image(.newHaidilao)
                  .resizable()
                  .frame(width: 86, height: 86)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Bagian".localized + " \(subChapter.id)")
                  .font(.pinyin())
                  .fontWeight(.bold)
               Text(subChapter.title)
                  .font(.subJudul())
               VStack(spacing: 0){
                  Text(subChapter.pinyin)
                     .multilineTextAlignment(.leading)
                     .font(.pinyin())
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .foregroundStyle(.emptyListText)
                  Text(subChapter.hanzi)
                     .multilineTextAlignment(.leading)
                     .font(.hanzi())
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .foregroundStyle(.emptyListText)
               }
               
               HStack(spacing: 2){
                  Image(systemName: "clock")
                     .foregroundStyle(.emptyListText)
                     .font(.normalText())
                  
                   Text("sekitar 10 menit".localized)
                     .foregroundStyle(.emptyListText)
                     .font(.pinyin())
               }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         
         Image(systemName: isLocked ? "lock" : "chevron.right")
              .foregroundStyle(isLocked ? .padlock : .orangeDarkMode)
              .fontWeight(.bold)
              .onTapGesture {
                 if !journeyVM.isSubChapterLocked(storyId: id, subChapter: subChapter) {
                    viewModel.loadChat(storyId: id, subChapterId: subChapter.id)
                    
                    router.push(.loadingPage(screen : .storyPage(chapterId: id, subChapterId: subChapter.id)))

                     //router.push(.loadingPage(chapterId: storyId, subChapterId: subChapter.id))
                 }
              }
         
         Spacer()
      }
//      .frame(width: 340)
      .padding()
      .background(.cardBackground)
      .overlay(
         RoundedRectangle(cornerRadius: 20)
            .stroke(.customLightGray, lineWidth: 1)
      )
   }
}
//
//#Preview {
//   SubChapterCard(labelImage: .haidilaoChapter, chapter: "Bagian 1", title: "Perkenalan", pinyin: "jiè shào", hanzi: "介 绍",isLocked: true, id: 1, subChapterId: 1)
//      .environmentObject(Router())
//      .environmentObject(StoryViewModel())
//      .environmentObject(HomeViewModel())
//}

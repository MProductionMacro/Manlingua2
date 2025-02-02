import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .cornerRadius(2)
                
                Rectangle()
                    .foregroundColor(.green)
                    .cornerRadius(2)
                    .frame(width: geometry.size.width * progress)
            }
        }
    }
}

#Preview {
    ProgressBar(progress: 0.0)
}

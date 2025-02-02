import SwiftUI

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        //clipShape(RoundedCornersShape(radius: radius, corners: corners))
        clipShape(CustomRoundedRectangle(cornerRadius: radius, corners: corners))
    }
}

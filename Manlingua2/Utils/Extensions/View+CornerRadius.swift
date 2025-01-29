//
//  View+CornerRadius.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 30/10/24.
//
import SwiftUI

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        //clipShape(RoundedCornersShape(radius: radius, corners: corners))
        clipShape(CustomRoundedRectangle(cornerRadius: radius, corners: corners))
    }
}

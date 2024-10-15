//
//  ButtonStyle.swift
//  Manlingua2
//
//  Created by Christine Putri on 15/10/24.
//

import Foundation

import SwiftUI


enum ButtonSize {
    case large
    case small
    case custom(width: CGFloat, height: CGFloat)
    
    // Computed property to return the size based on the enum case
    var size: CGSize {
        switch self {
        case .large:
            return CGSize(width: 226, height: 64)
        case .small:
            return CGSize(width: 191, height: 48)
        case .custom(let width, let height):
            return CGSize(width: width, height: height)
        }
    }
}


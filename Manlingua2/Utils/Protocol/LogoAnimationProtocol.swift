//
//  LogoAnimationProtocol.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import Foundation

protocol LogoAnimationProtocol {
   var currentIndex: Int { get }
   func startIntroducing(duration: Double)
}

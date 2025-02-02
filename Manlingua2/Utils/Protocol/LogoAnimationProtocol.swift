import Foundation

protocol LogoAnimationProtocol {
   var currentIndex: Int { get }
   func startIntroducing(duration: Double)
}

import Foundation

protocol TalkingAnimationProtocol {
    var isTalking: Bool { get }
    func startTalking(duration: Double)
}

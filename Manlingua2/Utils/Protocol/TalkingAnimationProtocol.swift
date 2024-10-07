//
//  TalkingAnimationProtocol.swift
//  HXD
//
//  Created by Ferdinand Jacques on 14/08/24.
//

import Foundation

protocol TalkingAnimationProtocol {
    var isTalking: Bool { get }
    
    func startTalking(duration: Double)
}

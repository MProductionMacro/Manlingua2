//
//  VirtualAssistantModel.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 31/10/24.
//
import Foundation

enum VoiceChatStatsenum{
    case idle
    case recordingSpeech
    case processingSpeech
    case playingSpeech
    case error(Error)}

enum VoiceType : String, Codable, Hashable, Sendable, CaseIterable {
    case alloy
    case echo
    case fable
    case onyx
    case nova
    case shimmer
}

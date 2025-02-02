import Foundation

struct Prediction: Hashable, Decodable {
    public let `class`: String
    public let confidence: Double
}

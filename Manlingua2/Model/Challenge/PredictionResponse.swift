import Foundation

struct PredictionResponse: Hashable, Decodable {
    public let predictions: [Prediction]?
}

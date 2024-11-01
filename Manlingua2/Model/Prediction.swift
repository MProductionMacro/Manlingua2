//
//  Prediction.swift
//  Manlingua2
//
//  Created by Paulus Michael on 01/11/24.
//

import Foundation

struct Prediction: Hashable, Decodable {
    let `class`: String
    let confidence: Double
}

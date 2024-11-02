//
//  PredictionResponse.swift
//  Manlingua2
//
//  Created by Paulus Michael on 01/11/24.
//

import Foundation

struct PredictionResponse: Hashable, Decodable {
    let predictions: [Prediction]
}

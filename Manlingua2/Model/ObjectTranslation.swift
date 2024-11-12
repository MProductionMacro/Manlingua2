//
//  ObjectTranslation.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/11/24.
//

import SwiftUI

// Define a model for each object (matching the FastAPI Object model)
struct Object: Codable {
    let hanzi: String
    let pinyin: String
    let meaning: String
}

// Define the response model to match the FastAPI response
struct ObjectResponse: Codable {
    let objects: [String: Object]  // Dictionary with string keys for object names
}

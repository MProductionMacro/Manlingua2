//
//  ObjectTranslation.swift
//  Manlingua2
//
//  Created by Paulus Michael on 12/11/24.
//

import SwiftUI

// Define a model for each object (matching the FastAPI Object model)
struct Object: Codable, Hashable {
    public let hanzi: String
    public let pinyin: String
    public let meaning: String
}

// Define the response model to match the FastAPI response
struct ObjectResponse: Codable {
    public let objects: [String: Object]  // Dictionary with string keys for object names
}

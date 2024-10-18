//
//  APIResponse.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//


import Foundation

// Define the structure of the expected API response

struct APIResponse: Decodable {
    let text: String
}


struct APIData{
    // It's recommended to load the API key from a secure source, such as the Keychain or environment variables.
    static let apiURL = "https://api-inference.huggingface.co/models/jonatasgrosman/wav2vec2-large-xlsr-53-chinese-zh-cn"
}

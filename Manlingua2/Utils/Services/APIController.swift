//
//  APIController.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 18/10/24.
//

import Foundation

class APIController {
    static let instance = APIController()
    
    
    private init() {} // Ensure singleton pattern
    
    // Convert audio file to Data
    func convertAudioToData(audioPath: String) -> Data? {
        do {
            let audioData = try Data(contentsOf: URL(fileURLWithPath: audioPath))
            return audioData
        } catch {
            print("Error loading audio file: \(error)")
            return nil
        }
    }
    
    // Retrieve API key from Info.plist
    func getApiKey() -> String? {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String, !apiKey.isEmpty else {
            print("API key not found or empty in Info.plist")
            return nil
        }
        return apiKey
    }
    
    // Fetch response from API
    func getResponse(audioPath: String) async -> String? {
        guard let audioData = convertAudioToData(audioPath: audioPath) else {
            print("Failed to convert audio to data")
            return nil
        }
        
        guard let url = URL(string: "https://api-inference.huggingface.co/models/ydshieh/wav2vec2-large-xlsr-53-chinese-zh-cn-gpt") else {
            print("Invalid URL")
            return nil
        }
        
//        guard let apiKey = getApiKey() else {
//            print("API key is missing or invalid")
//            return nil
//        }
        
        let apiKey = "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"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("audio/wav", forHTTPHeaderField: "Content-Type")
        request.httpBody = audioData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("HTTP Error: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return nil
            }
            
            //print("Berhasil sampe Sini")
            
            return try await getAnswer(data: data)
        } catch {
            print("Error during API request: \(error)")
            return nil
        }
    }
    
    func getResponseSecond(audioPath: String) async -> String? {
        guard let audioData = convertAudioToData(audioPath: audioPath) else {
            print("Failed to convert audio to data")
            return nil
        }
        
        guard let url = URL(string: "https://api-inference.huggingface.co/models/jonatasgrosman/wav2vec2-large-xlsr-53-chinese-zh-cn") else {
            print("Invalid URL")
            return nil
        }
        
//        guard let apiKey = getApiKey() else {
//            print("API key is missing or invalid")
//            return nil
//        }
        
        let apiKey = "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"
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("audio/wav", forHTTPHeaderField: "Content-Type")
        request.httpBody = audioData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("HTTP Error: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return nil
            }
            
            return try await getAnswer(data: data)
        } catch {
            print("Error during API request: \(error)")
            return nil
        }
    }
    
    // Decode JSON response
    private func getAnswer(data: Data) async throws -> String? {
        do {
            let answer = try JSONDecoder().decode(APIResponse.self, from: data)
            return answer.text
        } catch {
            print("Error decoding JSON: \(error)")
            throw error
        }
    }
}

//
//  APIController.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 15/10/24.
//

import Foundation

class APIController {
    static let instance = APIController()
    
    // Convert audio file to Data
    func convertAudioToData(audioPath: String) -> Data? {
        let url = URL(fileURLWithPath: audioPath)
        do {
            let audioData = try Data(contentsOf: url)
            return audioData
        } catch {
            print("Error loading audio file: \(error)")
            return nil
        }
    }
    
    // Retrieve API key from Info.plist
    func getApiKey() -> String {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            return apiKey
        }
        print("API key not found in Info.plist")
        return ""
    }
    
    // Fetch response from API
    func getResponse(audioPath: String) async -> String? {
        guard let audioData = convertAudioToData(audioPath: audioPath) else {
            print("Failed to convert audio to data")
            return nil
        }
        
        guard let url = URL(string: "https://api-inference.huggingface.co/models/jonatasgrosman/wav2vec2-large-xlsr-53-chinese-zh-cn") else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        let apiKey = getApiKey()
        
        if apiKey.isEmpty {
            print("API key is missing")
            return nil
        }
        
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("audio/wav", forHTTPHeaderField: "Content-Type") // Assuming the audio is in WAV format
        request.httpMethod = "POST"
        request.httpBody = audioData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP Error: \(httpResponse.statusCode)")
                return nil
            }
            
            return await getAnswer(data: data)
        } catch {
            print("Error during API request: \(error)")
            return nil
        }
    }
    
    // Decode JSON response
    func getAnswer(data: Data) async -> String? {
        do {
            let answer = try JSONDecoder().decode(APIResponse.self, from: data)
            return answer.text
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            return nil
        }
    }
}

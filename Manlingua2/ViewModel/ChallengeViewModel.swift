//
//  ChallengeViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import Foundation
import SystemConfiguration

class ChallengeViewModel: ObservableObject {
   @Published var objects: [String] = []
   @Published var errorMessage: String?
   
   private let baseURL = "http://10.60.32.8:8000"
   
   func fetchObjects() {
      guard let url = URL(string: "\(baseURL)/get_objects") else { return }
      
      URLSession.shared.dataTask(with: url) { data, response, error in
         if let error = error {
            DispatchQueue.main.async {
               self.errorMessage = "Failed to fetch objects: \(error.localizedDescription)"
            }
            return
         }
         
         if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
            guard let data = data else { return }
            
            do {
               if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let objectNames = json["objects"] as? [String] {
                  DispatchQueue.main.async {
                     self.objects = objectNames
                  }
               }
            } catch {
               DispatchQueue.main.async {
                  self.errorMessage = "Failed to parse object data"
               }
            }
         } else {
            DispatchQueue.main.async {
               self.errorMessage = "Failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)"
            }
         }
      }.resume()
   }
}

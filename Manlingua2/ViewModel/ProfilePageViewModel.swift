import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
   @Published public var name: String = "Loading..."
    //@Published public var isShowProfilePict : Bool = false
   
   init() {
      //fetchUserName()
   }
   
   
   public func fetchUserName() {
       /*
      guard let userID = Auth.auth().currentUser?.uid else {
         name = "Unknown"
         return
      }
      
      let db = Firestore.firestore()
      db.collection("users").document(userID).getDocument { document, error in
         if let error = error {
            print("Error fetching name: \(error.localizedDescription)")
            self.name = "Error"
            return
         }
         if let document = document, document.exists {
            self.name = document.data()?["name"] as? String ?? "No Name"
         } else {
            self.name = "Unknown"
         }
      }
        */
   }
   
   @MainActor public func getLevel() -> String {
      //Sementara gini dulu, tapi nanti sepertinya manggil Level itu ngelibatin langkah yg lebih kompleks
       let userRank = UserRank.allCases
       return userRank[SwiftDataServices.shared.getRank()].rawValue
      //return "Perunggu".localized
   }
   
}


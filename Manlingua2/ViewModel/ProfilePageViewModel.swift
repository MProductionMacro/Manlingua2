//
//  ProfileViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 27/10/24.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

//Datanya dari mana kan masih belum tau cara ngitungnya persisnya gimana
//Jadi untuk sementara, pake class dummy dulu kayak gini. Supaya bisa ngeload chart di ProfilePageView
struct SimpleItem: Hashable{
   let name: String
   let value: Int
}

class ProfileViewModel: ObservableObject {
    @Published var name: String = "Loading..."
       
       init() {
          fetchUserName()
       }
    
   let datas = [
      SimpleItem(name: "Terjemah", value: 1),
      SimpleItem(name: "Dengar", value: 3),
      SimpleItem(name: "Ucap", value: 2),
      SimpleItem(name: "Obrol", value: 4)
   ]
   
    func fetchUserName() {
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
        }
   
   func getLevel() -> String {
      //Sementara gini dulu, tapi nanti sepertinya manggil Level itu ngelibatin langkah yg lebih kompleks
      return "Perunggu"
   }
   
}


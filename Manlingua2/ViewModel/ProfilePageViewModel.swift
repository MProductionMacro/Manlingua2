//
//  ProfileViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 27/10/24.
//
import Foundation

//Datanya dari mana kan masih belum tau cara ngitungnya persisnya gimana
//Jadi untuk sementara, pake class dummy dulu kayak gini. Supaya bisa ngeload chart di ProfilePageView
struct SimpleItem: Hashable{
   let name: String
   let value: Int
}

class ProfileViewModel: ObservableObject {
   let datas = [
      SimpleItem(name: "Terjemah", value: 1),
      SimpleItem(name: "Dengar", value: 3),
      SimpleItem(name: "Ucap", value: 2),
      SimpleItem(name: "Obrol", value: 4)
   ]
   
   func getName() -> String {
      //Sementara gini dulu, tapi nanti sepertinya manggil Name itu ngelibatin langkah yg lebih kompleks
      return "Aling"
   }
   
   func getLevel() -> String {
      //Sementara gini dulu, tapi nanti sepertinya manggil Level itu ngelibatin langkah yg lebih kompleks
      return "Bronze"
   }
   
}


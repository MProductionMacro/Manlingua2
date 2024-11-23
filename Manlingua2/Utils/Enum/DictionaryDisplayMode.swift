//
//  DictionaryDisplayMode.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 04/11/24.
//

enum DictionaryDisplayMode: Equatable, Hashable {
   case favorite(isFromHome: Bool)
   case story(id: Int)
}

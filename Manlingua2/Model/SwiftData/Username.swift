//
//  Username.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/11/24.
//

import SwiftData
import SwiftUI

@Model
class UserProfile{
    public var username: String
    public var imageData: Data
    
    init(username: String, imageData: Data){
        self.username = username
        self.imageData = imageData
    }
}

@Model
class Username{
    public var username: String
    
    init(username: String) {
        self.username = username
    }
}

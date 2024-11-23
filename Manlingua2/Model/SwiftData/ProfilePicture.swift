//
//  ProfilePicture.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 23/11/24.
//

import SwiftData
import SwiftUI

@Model
class ProfilePicture {
    var imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}

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

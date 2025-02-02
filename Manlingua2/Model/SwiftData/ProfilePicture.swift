import SwiftData
import SwiftUI

@Model
class ProfilePicture {
    public var imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}

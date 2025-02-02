enum Lang: String, Codable{
    case english = "en"
    case indonesian = "id"
}


import SwiftData

@Model
class Language{
    var lang: Lang
    init(lang: Lang){
        self.lang = lang
    }
}

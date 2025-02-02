import Foundation
import SwiftData

struct Vocabulary: Identifiable, Codable, Hashable {
    public let id = UUID()
    public let hanzi: String
    public let pinyin: String
    public let meaning: String
    public let hanziSentence: String
    public let pinyinSentence: String
    public let meaningSentence: String
    public let language: String
    
    enum CodingKeys: String, CodingKey {
        case hanzi
        case pinyin
        case meaning
        case hanziSentence
        case pinyinSentence
        case meaningSentence
        case language
    }
}

@Model
class VocabularyModel{
    public var id = UUID()
    public var hanzi: String
    public var pinyin: String
    public var meaning: String
    public var hanziSentence: String
    public var pinyinSentence: String
    public var meaningSentence: String
    public var language: String
    
    init(vocab: Vocabulary){
        self.hanzi = vocab.hanzi
        self.pinyin = vocab.pinyin
        self.meaning = vocab.meaning
        self.hanziSentence = vocab.hanziSentence
        self.pinyinSentence = vocab.pinyinSentence
        self.meaningSentence = vocab.meaningSentence
        self.language = vocab.language
    }
}

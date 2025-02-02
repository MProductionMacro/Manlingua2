import XCTest
@testable import Manlingua

class DictionaryTests: XCTestCase {
    var viewModel: DictionaryViewModel!
    var mockVocabularies: [Vocabulary]!
    
    override func setUp() {
        super.setUp()
        
        // Initialize the viewModel
        viewModel = DictionaryViewModel()
        
        // Create mock vocabularies
        mockVocabularies = [
            Vocabulary(hanzi: "故事一", pinyin: "gù shì yī", meaning: "Story 1", hanziSentence: "这是故事一", pinyinSentence: "zhè shì gù shì yī", meaningSentence: "This is story 1", language: "en"),
            Vocabulary(hanzi: "故事二", pinyin: "gù shì èr", meaning: "Story 2", hanziSentence: "这是故事二", pinyinSentence: "zhè shì gù shì èr", meaningSentence: "This is story 2", language: "en")
        ]
    }
    
    override func tearDown() {
        viewModel = nil
        mockVocabularies = nil
        super.tearDown()
    }

    // Test case for adding vocabulary to the viewModel
    @MainActor func testAddVocabulary() {
        // Before adding, vocabularies array should be empty
        XCTAssertTrue(viewModel.vocabularies.isEmpty)
        
        // Add mock vocabulary
        viewModel.addVocabulary(mockVocabularies[0])
        print(viewModel.vocabularies)
        
        
        if SwiftDataServices.shared.getLanguage()  == .indonesian{
            XCTAssertEqual(viewModel.vocabularies.count, 1)
        }
        else{
            XCTAssertEqual(viewModel.vocabularies_en.count, 1)
        }
        // After adding, vocabularies array should contain the vocabulary
        //XCTAssertEqual(viewModel.vocabularies[0].hanzi, mockVocabularies[0].hanzi)
    }


    // Test case for getting the total number of vocabularies
    func testGetNumberVocabularies() {
        // Add some vocabularies to both lists
        viewModel.vocabularies = mockVocabularies
        viewModel.vocabularies_en = mockVocabularies
        
        // Test the number of vocabularies
        XCTAssertEqual(viewModel.getNumberVocabularies(), mockVocabularies.count * 2)
    }

    // Test case for checking if vocabularies are empty
    func testIsVocabsEmpty() {
        // Test if vocabularies are empty initially
        XCTAssertTrue(viewModel.isVocabsEmpty())
        
        // Add a vocabulary and check again
        viewModel.vocabularies.append(mockVocabularies[0])
        XCTAssertFalse(viewModel.isVocabsEmpty())
    }
}

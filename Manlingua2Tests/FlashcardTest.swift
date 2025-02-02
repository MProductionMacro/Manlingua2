import XCTest
@testable import Manlingua

@MainActor
class FlashcardTests: XCTestCase {
    
    var viewModel: FlashcardViewModel!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = FlashcardViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testCheckResult() throws {
        // Set up mock data
        let mockVocabulary = Vocabulary(hanzi: "你好", pinyin: "nǐ hǎo", meaning: "hello", hanziSentence:"Testing", pinyinSentence: "Testing", meaningSentence: "Testing", language: "en")
        viewModel.vocabularies = [mockVocabulary]
        viewModel.currentIndex = 0
        
        // Set up a correct answer
        viewModel.apiResult = "你好"
        
        // Test checkResult method
        XCTAssertTrue(viewModel.checkResult(), "The result should match the current vocabulary.")
        
        // Test with an incorrect answer
        viewModel.apiResult = "再见"
        XCTAssertFalse(viewModel.checkResult(), "The result should not match the current vocabulary.")
    }

    func testReshuffleCards() throws {
        // Set up mock data
        let vocab1 = Vocabulary(hanzi: "你好", pinyin: "nǐ hǎo", meaning: "hello", hanziSentence:"Testing", pinyinSentence: "Testing", meaningSentence: "Testing", language: "en")
        let vocab2 = Vocabulary(hanzi: "再见", pinyin: "zài jiàn", meaning: "goodbye", hanziSentence:"Testing", pinyinSentence: "Testing", meaningSentence: "Testing", language: "en")
        viewModel.vocabularies = [vocab1, vocab2]
        viewModel.vocabularies_en = [vocab1, vocab2]

        // Initial state
        XCTAssertEqual(viewModel.vocabularies.count, 2, "There should be 2 vocabularies.")

        // Call reshuffleCards
        viewModel.reshuffleCards()

        // Check if the cards are shuffled
        XCTAssertNotEqual(viewModel.vocabularies[0].hanzi, "你好", "The vocabulary order should be shuffled.")
    }

    func testCheckAnswer() throws {
        // Set up mock data
        let vocab1 = Vocabulary(hanzi: "你好", pinyin: "nǐ hǎo", meaning: "hello", hanziSentence:"Testing", pinyinSentence: "Testing", meaningSentence: "Testing", language: "en")
        viewModel.showVocabularies = [vocab1]
        viewModel.currentIndex = 0
        
        // Correct answer
        let correctAnswer = "你好"
        XCTAssertTrue(viewModel.checkAnswer(answer: correctAnswer), "The answer should be correct.")
        
        // Incorrect answer
        let incorrectAnswer = "再见"
        XCTAssertFalse(viewModel.checkAnswer(answer: incorrectAnswer), "The answer should be incorrect.")
    }

    func testSaveDailyProgress() throws {
        // Initial streak should be 0
        XCTAssertEqual(SwiftDataServices.shared.streak, 0, "Initial streak should be 0.")

        // Simulate saving daily progress
        viewModel.saveDailyProgress()

        // Test if streak has been incremented
        XCTAssertEqual(SwiftDataServices.shared.streak, 1, "Streak should be incremented after completing the task.")
        
        // Test if task progress is saved
        XCTAssertGreaterThan(SwiftDataServices.shared.totalTasks, 0, "Total tasks should be updated.")
    }
}

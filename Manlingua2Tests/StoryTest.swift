import XCTest
@testable import Manlingua

class StoryTests: XCTestCase {
    var viewModel: StoryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = StoryViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor func testSaveDailyProgress() {
        let initialStreak = SwiftDataServices.shared.streak
        viewModel.saveDailyProgress()
        XCTAssertGreaterThanOrEqual(SwiftDataServices.shared.streak, initialStreak)
    }
    
    func testCorrectAction() {
        var modalAppeared = true
        var hasAnswered = true
        let initialIndex = viewModel.currentIndex
        viewModel.correctAction(modalAppeared: &modalAppeared, hasAnswered: &hasAnswered)
        XCTAssertFalse(modalAppeared)
        XCTAssertFalse(hasAnswered)
        XCTAssertEqual(viewModel.currentIndex, initialIndex + 1)
    }
    
    func testWrongAction() {
        var modalAppeared = true
        var hasAnswered = true
        let initialIndex = viewModel.currentIndex
        viewModel.wrongAction(modalAppeared: &modalAppeared, hasAnswered: &hasAnswered)
        XCTAssertFalse(modalAppeared)
        XCTAssertFalse(hasAnswered)
        XCTAssertEqual(viewModel.currentIndex, max(0, initialIndex - 1))
    }
    
    func testTryAgainAction() {
        var modalAppeared = false
        var hasAnswered = true
        viewModel.tryAgainAction(modalAppeared: &modalAppeared, hasAnswered: &hasAnswered)
        XCTAssertTrue(modalAppeared)
        XCTAssertFalse(hasAnswered)
    }
    
    func testLoadChat() {
        viewModel.loadChat(storyId: 1, subChapterId: 1)
        XCTAssertFalse(viewModel.chats.isEmpty)
    }
    
    func testLoadChatPreview() {
        viewModel.loadChatPreview()
        XCTAssertFalse(viewModel.chat_preview.isEmpty)
    }
    
    @MainActor func testUpdateUserProgress() {
        let initialLatestStory = SwiftDataServices.shared.latestStory
        let initialLatestSubChapter = SwiftDataServices.shared.latestSubChapter
        viewModel.updateUserProgress(currentStory: initialLatestStory, currentSubChapter: initialLatestSubChapter)
        XCTAssertGreaterThanOrEqual(SwiftDataServices.shared.latestSubChapter, initialLatestSubChapter)
    }
}

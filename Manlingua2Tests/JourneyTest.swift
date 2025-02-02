import XCTest
@testable import Manlingua

class JourneyTests: XCTestCase {
    var viewModel: JourneyViewModel!
    var mockSwiftData: SwiftDataServices!
    
    @MainActor override func setUp() {
        super.setUp()
        mockSwiftData = SwiftDataServices.shared
        viewModel = JourneyViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadStoryData_Success() {
        let storyId = 1
        viewModel.loadStoryData(storyId: storyId)
        XCTAssertNotNil(viewModel.story, "Story seharusnya berhasil dimuat.")
    }
    
    func testLoadStoryData_FileNotFound() {
        let storyId = 999 // ID yang tidak ada filenya
        viewModel.loadStoryData(storyId: storyId)
        XCTAssertNil(viewModel.story, "Story seharusnya nil karena file tidak ditemukan.")
    }
    
    @MainActor func testIsSubChapterLocked_StoryUnlocked() {
        mockSwiftData.latestStory = 4
        mockSwiftData.storyProgress = [3, 3, 3, 1]
        
        let subChapter = SubChapter(
            id: 1,
            title: "Perkenalan Diri",
            pinyin: "wǒ jiào Lǐ Míng",
            hanzi: "我叫李明",
            duration: 120,
            chat_json: "Chat1_1_id.json",
            isDone: false
        )
        XCTAssertFalse(viewModel.isSubChapterLocked(storyId: 3, subChapter: subChapter))
    }
    
    @MainActor func testIsSubChapterLocked_StoryLocked() {
        mockSwiftData.latestStory = 1
        mockSwiftData.storyProgress = [1, 1, 1, 1]
        
        let subChapter = SubChapter(
            id: 1,
            title: "Perkenalan Diri",
            pinyin: "wǒ jiào Lǐ Míng",
            hanzi: "我叫李明",
            duration: 120,
            chat_json: "Chat1_1_id.json",
            isDone: false
        )
        XCTAssertTrue(viewModel.isSubChapterLocked(storyId: 3, subChapter: subChapter))
    }
}

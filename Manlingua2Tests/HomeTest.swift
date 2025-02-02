import XCTest
import Combine
@testable import Manlingua // Replace with your actual app name module

@MainActor
class HomeTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockData: Data!
    var originalUrlMethod: Method?

    override func setUp() {
        super.setUp()
        
        // Mock JSON data for testing
        mockData = """
        [
            {
                "id": 1,
                "number": 1,
                "title": "Story 1",
                "hanzi": "故事一",
                "description": "This is story 1.",
                "pinyin": "gù shì yī",
                "subChapter": [
                    {
                        "id": 1,
                        "title": "SubChapter 1",
                        "pinyin": "pīn yīn 1",
                        "hanzi": "子章节一",
                        "duration": 5,
                        "chat_json": "{\"chat\": \"Hello!\"}",
                        "isDone": false
                    }
                ],
                "isDone": false
            }
        ]
        """.data(using: .utf8)!

        // Swizzle the method to return mock data

        // Initialize the viewModel
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        // Restore the original method after each test
        restoreOriginalMethod()
        viewModel = nil
        super.tearDown()
    }

    // Test successful loading of valid JSON
    func testLoadStories_withValidJSON() {
        // Call loadStories method to simulate loading the data
        viewModel.loadStories()

        // Assert that the stories array is populated correctly
        let result = viewModel.stories_example.count == 0
        XCTAssertFalse(result)
        /*
        XCTAssertEqual(viewModel.stories_example[0].title, "Story 1")
        XCTAssertEqual(viewModel.stories_example[0].subChapter.count, 1)
        XCTAssertEqual(viewModel.stories_example[0].subChapter[0].title, "SubChapter 1")
         */
    }

    // Test handling of invalid JSON
    func testLoadStories_withInvalidJSON() {
        
        swizzleBundleMethod()
        
        // Provide invalid mock JSON data
        let invalidJSON = """
        [
            {
                "id": 1,
                "number": 1,
                "title": "Story 1",
                "hanzi": "故事一",
                "description": "This is story 1.",
                "pinyin": "gù shì yī",
                "subChapter": [
                    {
                        "id": 1,
                        "title": "SubChapter 1",
                        "pinyin": "pīn yīn 1",
                        "hanzi": "子章节一",
                        "duration": 5,
                        "chat_json": "{\"chat\": \"Hello!\"}",
                        "isDone": false
                    }
                ],
                "isDone": false
        """.data(using: .utf8)!

        // Swizzle to return invalid JSON
        mockData = invalidJSON

        // Call loadStories method to simulate loading invalid data
        viewModel.loadStories()

        // Assert that the stories array is still empty
        XCTAssertEqual(viewModel.stories_example.count, 0)
    }

    // Test if JSON file is not found
    func testLoadStories_withFileNotFound() {
        // Simulate no data (nil)
        mockData = nil

        // Call loadStories method to simulate loading with no file
        viewModel.loadStories()

        // Assert that the stories array is still empty
        XCTAssertEqual(viewModel.stories_example.count, 0)
    }

    // Swizzle Bundle's url(forResource:withExtension:) method to return mock data
    private func swizzleBundleMethod() {
        guard let originalMethod = class_getInstanceMethod(Bundle.self, #selector(Bundle.url(forResource:withExtension:))) else {
            fatalError("Original method not found.")
        }
        
        originalUrlMethod = originalMethod

        let swizzledImplementation: @convention(block) (Bundle, String, String) -> URL? = { _, resource, _ in
            if resource == "Story_Example_en.json" {
                return URL(fileURLWithPath: resource) // Simulate finding the resource, but don't actually access the filesystem
            }
            return nil
        }

        let swizzledMethod = imp_implementationWithBlock(swizzledImplementation)
        method_setImplementation(originalMethod, swizzledMethod)
    }

    // Restore the original method after the test
    private func restoreOriginalMethod() {
        guard let originalUrlMethod = originalUrlMethod else { return }
        method_setImplementation(originalUrlMethod, method_getImplementation(originalUrlMethod))
    }
}


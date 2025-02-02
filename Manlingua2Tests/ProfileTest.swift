import XCTest
@testable import Manlingua

class ProfileTest: XCTestCase {

    var viewModel: ProfileViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ProfileViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test getLevel function
    @MainActor func testGetLevel() {
        // Mock SwiftDataServices to return a specific rank
        let mockRank: Int = 2
        
        // Get the level
        let level = viewModel.getLevel()
        
        // Verify the level is correct
        XCTAssertEqual(level, "Perunggu", "The level should be 'Perunggu' for rank 2.")
        
        // You can expand this by adding more test cases for different ranks
        let level1 = viewModel.getLevel()
        XCTAssertEqual(level1, "Bronze", "The level should be 'Bronze' for rank 0.")
    }
}



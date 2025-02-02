import XCTest
@testable import Manlingua

@MainActor
class ChallengeTests: XCTestCase {

    var viewModel: ChallengeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ChallengeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test the saveDailyProgress function
    func testSaveDailyProgress() {
        let mockDate = Date() // Using the current date for simplicity
        let userDefaults = UserDefaults.standard
        userDefaults.set(mockDate, forKey: "lastCompletionDate")
        
        // Initially, streak should be 0
        XCTAssertEqual(SwiftDataServices.shared.streak, 0)

        // Call saveDailyProgress and check streak value
        viewModel.saveDailyProgress()
        
        // After calling saveDailyProgress, the streak should be incremented
        XCTAssertEqual(SwiftDataServices.shared.streak, 1)
    }

    // Test predictImage function
    func testPredictImage() {
        // Mock a valid UIImage (use any image)
        let mockImage = UIImage(systemName: "star")!
        
        // Use an expectation for async behavior
        let expectation = self.expectation(description: "Image Prediction")
        
        // Call predictImage and test that predictions are received
        viewModel.predictImage(mockImage)
        
        // Set a delay to wait for the asynchronous network call to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.isPredicted)
            XCTAssertNotNil(self.viewModel.predictions)
            expectation.fulfill()
        }
        
        // Wait for expectations to be fulfilled
        waitForExpectations(timeout: 3, handler: nil)
    }

    // Test fetchObjects function
    func testFetchObjects() {
        // We will mock the network response to return a sample response
        
        // Expectation for async behavior
        let expectation = self.expectation(description: "Fetch Objects")
        
        viewModel.fetchObjects()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertGreaterThan(self.viewModel.objects_example.count, 0, "Objects should be fetched successfully")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }

    // Test the updateRemainHour method
    func testUpdateRemainHour() {
        // Before calling updateRemainHour, the remaining time should be correctly initialized
        XCTAssertEqual(viewModel.remainHour, 24)
        XCTAssertEqual(viewModel.remainMinutes, 60)

        // Call the method to check if the time updates
        viewModel.updateRemainHour()

        // Check if the value is updated correctly (based on current time)
        XCTAssertTrue(viewModel.remainHour >= 0)
        XCTAssertTrue(viewModel.remainMinutes >= 0)
    }

    // Test the setupHourlyTimer method
    func testSetupHourlyTimer() {
        // Let's set up the timer and test that the remainHour is updated correctly.
        viewModel.setupHourlyTimer()
        
        // Simulate an update by manually calling updateRemainHour
        let initialRemainHour = viewModel.remainHour
        viewModel.updateRemainHour()
        
        // Test if remainHour was updated after calling the method
        XCTAssertNotEqual(viewModel.remainHour, initialRemainHour)
    }
}

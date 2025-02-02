import XCTest
@testable import Manlingua

// Mock AudioController for unit testing
class MockAudioController: AudioController {
    var mockStartRecordingResult: Bool = true
    var mockPermissionGranted: Bool = true
    
    override func requestPermission(completion: @escaping (Bool) -> Void) {
        completion(mockPermissionGranted)
    }
    
    override func startRecording() -> Bool {
        return mockStartRecordingResult
    }
    
    override func stopRecording() {
        // Mocked method does nothing, just to simulate stopping
    }
    
    override func playRecording() {
        // Mocked method simulates playing
    }
}

// Unit tests
class AudioRecorderTests: XCTestCase {
    
    var viewModel: AudioRecorderViewModel!
    var mockAudioController: MockAudioController!

    override func setUp() {
        super.setUp()
        mockAudioController = MockAudioController()
        viewModel = AudioRecorderViewModel()
    }

    override func tearDown() {
        viewModel = nil
        mockAudioController = nil
        super.tearDown()
    }

    // Test if recording starts when permission is granted
    func testStartRecordingWhenPermissionGranted() {
        mockAudioController.mockPermissionGranted = true
        mockAudioController.mockStartRecordingResult = true
        
        viewModel.requestPermissionAndRecord()
        
        XCTAssertTrue(viewModel.isRecording, "The recording should start when permission is granted.")
    }
    
    // Test if recording does not start when permission is denied
    func testStartRecordingWhenPermissionDenied() {
        mockAudioController.mockPermissionGranted = false
        
        viewModel.requestPermissionAndRecord()
        
        XCTAssertFalse(viewModel.isRecording, "The recording should not start when permission is denied.")
    }
    
    // Test if stopping recording works
    func testStopRecording() {
        mockAudioController.mockPermissionGranted = true
        mockAudioController.mockStartRecordingResult = true
        viewModel.requestPermissionAndRecord() // Start recording
        
        viewModel.requestPermissionAndRecord() // Stop recording
        
        XCTAssertFalse(viewModel.isRecording, "The recording should stop after stopping.")
        XCTAssertTrue(viewModel.hasRecording, "The hasRecording flag should be true after stopping the recording.")
    }
    
    // Test if playing a recording works
    func testPlayRecording() {
        viewModel.isRecording = false // Simulate that recording has been stopped
        viewModel.hasRecording = true
        
        viewModel.playRecording()
        
        XCTAssertTrue(viewModel.isPlaying, "The recording should start playing if there is a recording.")
    }
    
    // Test if play recording doesn't work while recording
    func testPlayRecordingWhileRecording() {
        viewModel.isRecording = true
        
        viewModel.playRecording()
        
        XCTAssertFalse(viewModel.isPlaying, "The recording should not play while recording is in progress.")
    }
    
    // Test if delegate method works for stopping playback
    func testAudioControllerDidStopPlaying() {
        viewModel.audioControllerDidStopPlaying()
        
        XCTAssertFalse(viewModel.isPlaying, "The isPlaying flag should be false when audio playback stops.")
    }
}

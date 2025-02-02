/*
import XCTest
import XCAOpenAIClient
import AVFoundation
@testable import Manlingua

class AIAssistantTests: XCTestCase {

    var viewModel: AIAssistantViewModel!

    // Mock dependencies
    var mockAudioRecorder: MockAudioRecorder!
    var mockAudioPlayer: MockAudioPlayer!
    var mockClient: MockOpenAIClient!

    override func setUp() {
        super.setUp()
        
        // Initialize ViewModel and Mocks
        mockAudioRecorder = MockAudioRecorder()
        mockAudioPlayer = MockAudioPlayer()
        mockClient = MockOpenAIClient()
        
        // Setup ViewModel with mock dependencies
        viewModel = AIAssistantViewModel()

    }

    override func tearDown() {
        // Cleanup
        viewModel = nil
        mockAudioRecorder = nil
        mockAudioPlayer = nil
        mockClient = nil
        
        super.tearDown()
    }

    // Test startCaptureAudio
    func testStartCaptureAudio() {
        viewModel.startCaptureAudio()
        
        // Assert that the audio recorder is recording
        XCTAssertTrue(mockAudioRecorder.isRecording)
    }
    
    // Test finishCaptureAudio
    func testFinishCaptureAudio() {
        // Given
        let mockAudioData = Data()
        mockAudioRecorder.simulateFinishRecording()

        // When
        viewModel.finishCaptureAudio()

        // Then
        XCTAssertTrue(mockAudioPlayer.playCalled)
        XCTAssertEqual(viewModel.state, .playingSpeech)
    }

    // Test transcription (successful case)
    func testTranscribeAudioInMandarin() async throws {
        // Given
        let mockTranscribedText = "你好"
        mockClient.mockTranscribedText = mockTranscribedText

        // When
        let transcription = try await viewModel.transcribeAudioInMandarin()

        // Then
        XCTAssertEqual(transcription, mockTranscribedText)
    }
    
    // Test transcription (failure case)
    func testTranscribeAudioInMandarinFailure() async throws {
        // Given
        mockClient.shouldThrowError = true
        
        // When / Then
        do {
            _ = try await viewModel.transcribeAudioInMandarin()
            XCTFail("Expected error but got success.")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    // Test processSpeechTask
    func testProcessSpeechTask() async {
        // Given
        let mockAudioData = Data()
        mockClient.mockResponseText = "Response text from OpenAI"

        // When
        let task = viewModel.processSpeechTask(audioString: mockAudioData)

        // Then
        // Assert that the OpenAI client was called and the audio was played
        await task
        XCTAssertTrue(mockClient.wasPromptCalled)
        XCTAssertTrue(mockAudioPlayer.playCalled)
    }
}

// Mock classes for testing

class MockAudioRecorder: AVAudioRecorder {
    var isRecording = false
    
    override func record() -> Bool {
        isRecording = true
        return true
    }
    
    func simulateFinishRecording() {
        isRecording = false
    }
}

class MockAudioPlayer: AVAudioPlayer {
    var playCalled = false
    
    override func play() {
        playCalled = true
    }
}

class MockOpenAIClient: OpenAIClient {
    var mockTranscribedText: String?
    var mockResponseText: String?
    var shouldThrowError = false
    var wasPromptCalled = false
    
    override func generateAudioTransciptions(audioData: Data) async throws -> String {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1, userInfo: nil)
        }
        return mockTranscribedText ?? "Mock Transcription"
    }
    
    override func promptChatGPT(prompt: String, assistantPrompt: String) async throws -> String {
        wasPromptCalled = true
        return mockResponseText ?? "Mock Response"
    }
    
    override func generateSpeechFrom(input: String, voice: VoiceType) async throws -> Data {
        return Data()
    }
}
*/

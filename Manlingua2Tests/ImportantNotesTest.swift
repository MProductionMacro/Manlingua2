import XCTest
@testable import Manlingua

@MainActor
class ImportantNotesTests: XCTestCase {

    var viewModel: ImportantNotesViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ImportantNotesViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // Test loadNotes function
    func testLoadNotes() {
        // Mocking a display mode
        let displayMode: NoteDisplayMode = .favorite
        
        // Call the method to load notes
        viewModel.loadNotes(from: displayMode)
        
        // Check that notes are populated
        XCTAssertFalse(viewModel.notes.isEmpty, "Notes should not be empty after loading favorite notes.")
        XCTAssertTrue(viewModel.notes_en.isEmpty, "Notes in English should be empty for favorite mode.")
    }

    // Test getNotes function for Indonesian language
    func testGetNotesIndonesian() {
        // Mock SwiftDataServices to return Indonesian language
        //SwiftDataServices.shared = MockSwiftDataServices(language: .indonesian)
        
        // Adding some notes to the list
        let mockNote = ImportantNote(title: "Test Note", allowed: "Yes", forbidden: "No", caution: "Careful", language: "id")
        viewModel.notes.append(mockNote)

        // Get the notes
        let notes = viewModel.getNotes()

        // Test if the notes are returned correctly in the Indonesian language
        XCTAssertEqual(notes.count, 1, "There should be 1 note returned.")
        XCTAssertEqual(notes.first?.title, "Test Note", "The note title should match.")
    }
    
    // Test getNotes function for English language
    func testGetNotesEnglish() {
        // Mock SwiftDataServices to return English language
        
        // Adding some notes to the list
        let mockNote = ImportantNote(title: "Test Note", allowed: "Yes", forbidden: "No", caution: "Careful", language: "en")
        viewModel.notes_en.append(mockNote)

        // Get the notes
        let notes = viewModel.getNotes()

        // Test if the notes are returned correctly in the English language
        XCTAssertEqual(notes.count, 1, "There should be 1 note returned.")
        XCTAssertEqual(notes.first?.title, "Test Note", "The note title should match.")
    }

    // Test isNotesEmpty function
    func testIsNotesEmpty() {
        // When both notes and notes_en are empty
        XCTAssertTrue(viewModel.isNotesEmpty(), "Notes should be empty when both lists are empty.")
        
        // When notes contain data
        let mockNote = ImportantNote(title: "Test Note", allowed: "Yes", forbidden: "No", caution: "Careful", language: "id")
        viewModel.notes.append(mockNote)
        
        XCTAssertFalse(viewModel.isNotesEmpty(), "Notes should not be empty when notes list contains data.")
        
        // When notes_en contains data
        viewModel.notes_en.append(mockNote)
        
        XCTAssertFalse(viewModel.isNotesEmpty(), "Notes should not be empty when notes_en list contains data.")
    }

}


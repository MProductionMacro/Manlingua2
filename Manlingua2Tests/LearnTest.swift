import XCTest
@testable import Manlingua

class LearnTest: XCTestCase {
    
    var viewModel: LearnViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LearnViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetPinyinFinals() {
        let expectedFinals = [
            ["a", "o", "e", "i", "u", "ü"],
            ["ai", "ei", "ui", "ao", "ou", "iu", "ie", "üe", "an", "en", "in", "un"],
            ["ün", "er"],
            ["ang", "eng", "ing", "ong"]
        ]
        XCTAssertEqual(viewModel.getPinyinFinals(), expectedFinals)
    }
    
    func testGetPinyinInisial() {
        let expectedInisial = [
            ["b", "p", "m", "f"],
            ["d", "t", "n", "l"],
            ["g", "k", "h"],
            ["j", "q", "x"],
            ["z", "c", "s"],
            ["zh", "ch", "sh", "r"]
        ]
        XCTAssertEqual(viewModel.getPinyinInisial(), expectedInisial)
    }
    
    func testGetPinyinNada() {
        let expectedNada = ["ā", "á", "ǎ", "à"]
        XCTAssertEqual(viewModel.getPinyinNada(), expectedNada)
    }
}

import XCTest
@testable import SimpleKeyboard

final class SimpleKeyboardTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SimpleKeyboard().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

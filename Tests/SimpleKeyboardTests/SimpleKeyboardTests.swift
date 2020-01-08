import XCTest
import SwiftUI
@testable import SimpleKeyboard


final class SimpleKeyboardTests: XCTestCase {
    
    @ObservedObject var s = KeyboardSettings(language: .english, textInput: Binding.constant("")) {
        return
    }

    
    func test_create_settings(){
        let testInput = InputTester()

        let s = KeyboardSettings(language: Language.english, textInput: testInput)
        
        s.text = "abc"
        XCTAssertEqual(testInput.text, s.text)
    }
    
    func test_has_10_numbers(){
        XCTAssertEqual(Language.numbers.count, 10)
    }
    
    func test_standard_keyboard_action_works(){
        let action = XCTestExpectation(description: "StdKeyboardAction")
                
        let standard = SimpleStandardKeyboard(settings: .constant(KeyboardSettings(language: .english, textInput: Binding.constant("")) {
            action.fulfill()
        }))
        standard.settings.action?()
        
        wait(for: [action], timeout: 2)
        
    }
    
    func test_simple_keyboard_works(){
        let action = XCTestExpectation(description: "SimpleKeyboardAction")
        
        let simple = SimpleKeyboard(keys: [["0"],["1"]], textInput: $s.text) {
            action.fulfill()
        }
        
        simple.action?()
        
        wait(for: [action], timeout: 2)
    }
    
    static var allTests = [
        ("create_settings", test_create_settings),
        ("create_settings", test_create_settings),
        ("has_10_numbers", test_has_10_numbers),
        ("standard_keyboard_action_works", test_standard_keyboard_action_works),
        ("standard_keyboard_works", test_simple_keyboard_works),
    ]
}

import XCTest
import SwiftUI
@testable import SimpleKeyboard


final class SimpleKeyboardTests: XCTestCase {
    
    @ObservedObject var s = KeyboardSettings(language: .english, textInput: Binding.constant("")) {
        return
    }
    
    func create_settings(){
        
        let input = Binding.constant("")
        
        let s = KeyboardSettings(language: .english, textInput: input) {
            return
        }
        
        s.text = "abc"
        XCTAssertEqual(input.wrappedValue, s.text)
    }
    
    func has_10_numbers(){
        XCTAssertEqual(Language.numbers.count, 10)
    }
    
    func standard_keyboard_action_works(){
        let action = XCTestExpectation(description: "StdKeyboardAction")
                
        let standard = SimpleStandardKeyboard(settings: .constant(KeyboardSettings(language: .english, textInput: Binding.constant("")) {
            action.fulfill()
        }))
        standard.settings.action?()
        
        wait(for: [action], timeout: 2)
        
    }
    
    func simple_keyboard_works(){
        let action = XCTestExpectation(description: "SimpleKeyboardAction")
        
        let simple = SimpleKeyboard(keys: [["0"],["1"]], text: $s.text) {
            action.fulfill()
        }
        
        simple.action()
        
        wait(for: [action], timeout: 2)
    }
    
    static var allTests = [
        ("create_settings", create_settings),
        ("create_settings", create_settings),
        ("has_10_numbers", has_10_numbers),
        ("standard_keyboard_action_works", standard_keyboard_action_works),
        ("standard_keyboard_works", simple_keyboard_works),
    ]
}

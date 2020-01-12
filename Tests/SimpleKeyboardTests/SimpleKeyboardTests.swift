import XCTest
import SwiftUI
@testable import SimpleKeyboard


final class SimpleKeyboardTests: XCTestCase {
    
    @ObservedObject var s = KeyboardSettings(language: .english, textInput: Binding.constant(""))
    @ObservedObject var tester = InputTester()
    
    
    override func setUp() {
        tester = InputTester()
        s = KeyboardSettings(language: .english, textInput: Binding.constant(""))
    }
    
    func test_create_settings(){
        let t = InputTester()
        s.changeTextInput(to: t)
        
        s.text = "abc"
        XCTAssertEqual(t.text, s.text)
    }
    
    func test_has_10_numbers(){
        XCTAssertEqual(Language.numbers.count, 10)
    }
    
    func test_change_input(){
        let newInput = InputTester()
        s.changeTextInput(to: newInput)
    }
    
    func test_buttons(){
        
        let shift = ShiftKeyButton(isUpperCase: $tester.upperCase)
        XCTAssertNotNil(shift.body)
        
        let key = KeyButton(text: $tester.text, isUpperCase: $tester.upperCase, letter: "x")
        XCTAssertNotNil(key.body)
        
        let space = SpaceKeyButton(text: $tester.text)
        XCTAssertNotNil(space.body)

        let delete = DeleteKeyButton(text: $tester.text)
        XCTAssertNotNil(delete.body)

        let action = ActionKeyButton(icon: .done) {
            return
        }
        XCTAssertNotNil(action.body)

    }
    
    func test_standard_keyboard_action_works(){
        let action = XCTestExpectation(description: "StdKeyboardAction")
                
        let standard = SimpleStandardKeyboard(settings: .constant(KeyboardSettings(language: .english, textInput: Binding.constant("")) {
            action.fulfill()
        }))
        
        standard.settings.action?()
        
        XCTAssertNotNil(standard.body)
        
        wait(for: [action], timeout: 2)
        
    }
    
    func test_simple_keyboard_works(){
        let action = XCTestExpectation(description: "SimpleKeyboardAction")
        
        let simple = SimpleKeyboard(keys: [["0"],["1"]], textInput: $s.text) {
            action.fulfill()
        }
        
        XCTAssertNotNil(simple.body)
        
        simple.action?()
        
        wait(for: [action], timeout: 2)
    }
    
    static var allTests = [
        ("create_settings", test_create_settings),
        ("create_settings", test_create_settings),
        ("has_10_numbers", test_has_10_numbers),
        ("change_input", test_change_input),
        ("test_buttons", test_buttons),
        ("standard_keyboard_action_works", test_standard_keyboard_action_works),
        ("standard_keyboard_works", test_simple_keyboard_works),
    ]
}

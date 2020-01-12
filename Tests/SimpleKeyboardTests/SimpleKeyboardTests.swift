import XCTest
import SwiftUI
@testable import SimpleKeyboard


final class SimpleKeyboardTests: XCTestCase {
    
    @ObservedObject var tester = InputTester()
    
    
    override func setUp() {
        tester = InputTester()
    }

    func test_lnaguages_not_empty(){
        for l in Language.allCases {
            XCTAssertFalse(l.rows.isEmpty)
        }
    }

    func test_create_settings(){
        let t = InputTester()
        tester.settings.changeTextInput(to: t)
        
        tester.settings.text = "abc"
        XCTAssertEqual(t.text, tester.settings.text)
    }
    
    func test_has_10_numbers(){
        XCTAssertEqual(Language.numbers.count, 10)
    }
    
    func test_change_input(){
        let newInput = InputTester()
        tester.settings.changeTextInput(to: newInput)
    }
    
    func test_icons(){
        XCTAssertNotNil(Icon.done)
        XCTAssertNotNil(Icon.go)
        XCTAssertNotNil(Icon.search)
    }
    
    func test_buttons(){
        let expect = XCTestExpectation()
        
        let key = KeyButton(text: $tester.text, isUpperCase: $tester.settings.isUpperCase, letter: "x")
        XCTAssertNotNil(key.body)
        XCTAssertEqual(key.actualLetter, "x")
        
        tester.settings.isUpperCase = false

        let shift = ShiftKeyButton(isUpperCase: $tester.settings.isUpperCase)
        XCTAssertNotNil(shift.body)
        
        tester.settings.isUpperCase = true
        XCTAssertEqual(key.actualLetter, "X")
        
        let space = SpaceKeyButton(text: $tester.text)
        XCTAssertNotNil(space.body)

        let delete = DeleteKeyButton(text: $tester.text)
        XCTAssertNotNil(delete.body)

        tester.text = "xyz"
        
        XCTAssertEqual(key.text, space.text)
        XCTAssertEqual(key.text, delete.text)
        XCTAssertEqual(key.text, "xyz")

        let action = ActionKeyButton(icon: .done) {
            expect.fulfill()
        }
        
        action.action()
        XCTAssertNotNil(action.body)

        wait(for: [expect], timeout: 3)
    }

    func test_standard_keyboard_init(){
        let standard = SimpleStandardKeyboard(settings: $tester.settings, textInput: $tester.text)
        standard.settings.text = "qwerty"
        XCTAssertEqual(standard.settings.text, tester.text)
        
        XCTAssertNotNil(standard.body)
    }
    
    func test_standard_keyboard_action_works(){
        let action = XCTestExpectation(description: "StdKeyboardAction")
        let settings = KeyboardSettings(language: Language.german, textInput: tester as SimpleKeyboardInput, showNumbers: true, showSpace: true, isUpperCase: tester.settings.isUpperCase) {
            action.fulfill()
        }
        
        tester.settings = settings
        
        let standard = SimpleStandardKeyboard(settings: $tester.settings)
        XCTAssertNotNil(standard.body)
        standard.settings.action?()
        
        standard.settings.isUpperCase = true
        XCTAssert(tester.settings.isUpperCase!)
        
        let newTester = InputTester()
        standard.settings.changeTextInput(to: newTester)
        standard.settings.text = "xyz"

        XCTAssertEqual(newTester.text, standard.settings.text)

        wait(for: [action], timeout: 2)
    }
    
    func test_simple_keyboard_works(){
        let action = XCTestExpectation(description: "SimpleKeyboardAction")
        let simple = SimpleKeyboard(keys: [["0"],["1", "2"]], textInput: $tester.text) {
            action.fulfill()
        }
        
        XCTAssertNotNil(simple.body)
        
        simple.action?()
        wait(for: [action], timeout: 2)
    }
    
    static var allTests = [
        ("test_lnaguages_not_empty", test_lnaguages_not_empty),
        ("test_icons", test_icons),
        ("test_standard_keyboard_init", test_standard_keyboard_init),
        ("create_settings", test_create_settings),
        ("has_10_numbers", test_has_10_numbers),
        ("change_input", test_change_input),
        ("test_buttons", test_buttons),
        ("standard_keyboard_action_works", test_standard_keyboard_action_works),
        ("standard_keyboard_works", test_simple_keyboard_works),
    ]
}

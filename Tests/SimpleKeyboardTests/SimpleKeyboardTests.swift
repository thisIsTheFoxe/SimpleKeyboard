import XCTest
import SwiftUI
@testable import SimpleKeyboard

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

final class SimpleKeyboardTests: XCTestCase {

    @ObservedObject var tester = InputTester()

    override func setUp() {
        tester = InputTester()
    }

    func test_native_input() {
        #if canImport(UIKit)
        let textField = UITextField()
        tester.settings.changeTextInput(to: textField)

        tester.settings.text = "UIKit"
        XCTAssertEqual(textField.text, "UIKit")
        #elseif canImport(AppKit)
        let textField = NSTextField()
        tester.settings.changeTextInput(to: textField)

        tester.settings.text = "AppKit"
        XCTAssertEqual(textField.stringValue, "AppKit")
        #endif
    }

    func test_lnaguages_not_empty() {
        for lang in Language.allCases {
            XCTAssertFalse(lang.rows(areUppercased: false).isEmpty)
            XCTAssertFalse(lang.rows(areUppercased: true).isEmpty)
            XCTAssertEqual(lang.spacing, 3)
        }
    }

    func test_create_settings() {
        let newTester = InputTester()
        tester.settings.changeTextInput(to: newTester)

        tester.settings.text = "abc"
        XCTAssertEqual(newTester.text, tester.settings.text)
    }

    func test_has_10_numbers() {
        XCTAssertEqual(Language.numbers(areUppercased: true).count, 10)
        XCTAssertEqual(Language.numbers(areUppercased: false).count, 10)
    }

    func test_change_input() {
        let newInput = InputTester()
        tester.settings.changeTextInput(to: newInput)
    }

    func test_icons() {
        XCTAssertNotNil(Icon.done)
        XCTAssertNotNil(Icon.go)
        XCTAssertNotNil(Icon.search)
    }

    func test_buttons() {
        let expect = XCTestExpectation()

        let key = KeyButton(text: $tester.text, letter: "x")
        XCTAssertNotNil(key.body)
        XCTAssertEqual(key.letter, "x")
        XCTAssertNoThrow(key.didClick())

        tester.settings.isUpperCase = false

        let shift = ShiftKeyButton(isUpperCase: $tester.settings.isUpperCase)
        XCTAssertNotNil(shift.body)

        tester.settings.isUpperCase = true
        XCTAssertEqual(tester.settings.isUpperCase, shift.isUpperCase)

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
        XCTAssertEqual(action.icon, .done)

        action.action()
        XCTAssertNotNil(action.body)

        wait(for: [expect], timeout: 3)
    }

    func test_standard_keyboard_init() {
        let standard = SimpleStandardKeyboard(settings: tester.settings, textInput: $tester.text)
        standard.settings.text = "qwerty"
        XCTAssertEqual(standard.settings.text, tester.text)
        XCTAssertNotNil(standard.body)
        XCTAssertNotNil(standard.spaceRow)
        XCTAssertNotNil(standard.keyboardRows)
        XCTAssertNotNil(standard.numbersRow)
        
        tester.settings.language = .french
        let standard2 = SimpleStandardKeyboard(settings: tester.settings, textInput: $tester.text)
        XCTAssertNotNil(standard2.keyboardRows)
    }

    func test_standard_keyboard_action_works() {
        let action = XCTestExpectation(description: "StdKeyboardAction")
        let settings = KeyboardSettings(
            language: Language.german,
            textInput: tester as SimpleKeyboardInput,
            showNumbers: true,
            showSpace: true,
            isUpperCase: tester.settings.isUpperCase) {
            action.fulfill()
        }

        tester.settings = settings

        let standard = SimpleStandardKeyboard(settings: tester.settings)
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

    func test_simple_keyboard_works() {
        let action = XCTestExpectation(description: "SimpleKeyboardAction")
        let simple = SimpleKeyboard(keys: [["0"], ["1", "2"]], textInput: $tester.text) {
            action.fulfill()
        }

        XCTAssertNotNil(simple.body)

        simple.action?()
        wait(for: [action], timeout: 2)
    }

    func test_keyboard_preview() {
        XCTAssertNotNil(SimpleKeyboard_Previews.previews)
        XCTAssertNotNil(SimpleStandardKeyboard_Previews.previews)
    }

    func test_french_accent_key() {
        let frButton = FRAccentKeyButton(text: $tester.text)
        XCTAssertNotNil(frButton)

        for char in "aeiouc" {
            tester.text.append(char)
            frButton.action()
            let modChar = String(tester.text.suffix(1))
            print(modChar)
            XCTAssertNotEqual(modChar, String(char))
        }
    }

    func test_corner_radius() {
        XCTAssertNotNil(RectCorner.allCorners)
        XCTAssertNotNil(RectCorner.bottomLeft)
        XCTAssertNotNil(RectCorner.topLeft)
        XCTAssertNotNil(RectCorner.bottomRight)
        XCTAssertNotNil(RectCorner.topRight)
        XCTAssertNotNil(EmptyView().cornerRadius(10, corners: .allCorners))
        XCTAssertEqual(
            RoundedCorner(radius: 10, corners: .allCorners).path(in: CGRect(x: 0, y: 0, width: 100, height: 100)),
            RoundedCorner(radius: 10, corners: .allCorners).path(in: CGRect(x: 0, y: 0, width: 100, height: 100)))
    }

    func test_theming_modifier() {
        let mod = OuterKeyboardThemingModifier(theme: .floating, backroundColor: Color.black)
        let mod2 = OuterKeyboardThemingModifier(theme: .system, backroundColor: Color.black)
        XCTAssertNotNil(EmptyView().modifier(mod))
        XCTAssertNotNil(EmptyView().modifier(mod2))
    }

    static var allTests = [
        ("test_native_input", test_native_input),
        ("test_lnaguages_not_empty", test_lnaguages_not_empty),
        ("test_icons", test_icons),
        ("test_standard_keyboard_init", test_standard_keyboard_init),
        ("create_settings", test_create_settings),
        ("has_10_numbers", test_has_10_numbers),
        ("change_input", test_change_input),
        ("test_buttons", test_buttons),
        ("standard_keyboard_action_works", test_standard_keyboard_action_works),
        ("standard_keyboard_works", test_simple_keyboard_works),
        ("test_keyboard_preview", test_keyboard_preview),
        ("test_french_accent_key", test_french_accent_key),
        ("test_corner_radius", test_corner_radius),
        ("test_theming_modifier", test_theming_modifier)
    ]
}

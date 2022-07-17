//
//  KeyboardSettings.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import Combine
import SwiftUI

public protocol SimpleKeyboardInput {
    var currentText: String { get }
    mutating func replaceAll(with text: String)
}

extension Binding: SimpleKeyboardInput where Value == String {
    public var currentText: String {
        self.wrappedValue
    }

    public mutating func replaceAll(with text: String) {
        self.wrappedValue = text
    }
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
extension NSTextField: SimpleKeyboardInput {
    public var currentText: String {
        self.stringValue
    }

    public func replaceAll(with text: String) {
        stringValue = text
    }
}
#endif

#if canImport(UIKit)
import UIKit

extension UITextField: SimpleKeyboardInput {
    public var currentText: String {
        self.text ?? ""
    }

    public func replaceAll(with text: String) {
        self.text = text
    }
}
#endif

public class KeyboardSettings: ObservableObject {
    public var text: String = "" {
        didSet {
            textInput?.replaceAll(with: text)
        }
    }

    @Published public var language: Language

    public var theme: KeyboardTheme

    /// `nil` mean there is no action icon
    var actionButton: Icon?

    public var textInput: SimpleKeyboardInput?
    public var action: (() -> Void)?

    @Published public var isShown = true

    @Published public var showNumbers: Bool
    @Published public var showSpace: Bool

    /// `nil` mean there is no need to switch, so there will be no shift-key
    @Published public var isUpperCase: Bool?

    /// `textInput` should be `nil` when working directly with SwiftUI,
    /// in that case you would bind your input directly to the `textInput` of the Keyboard
    public init(
        language: Language,
        textInput: SimpleKeyboardInput?,
        theme: KeyboardTheme = .system,
        actionButton: Icon? = .done,
        showNumbers: Bool = false,
        showSpace: Bool = true,
        isUpperCase: Bool? = nil,
        action: (() -> Void)? = nil) {
            self.textInput = textInput
            self.theme = theme
            self.language = language
            self.action = action
            self.showNumbers = showNumbers
            self.showSpace = showSpace
            self.isUpperCase = isUpperCase
            self.actionButton = actionButton
        }

    func changeTextInput(to newInput: SimpleKeyboardInput) {
        self.textInput = newInput
        self.text = newInput.currentText
    }
}

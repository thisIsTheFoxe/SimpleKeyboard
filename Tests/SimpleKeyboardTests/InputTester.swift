//
//  InputTester.swift
//  
//
//  Created by Henrik Storch on 1/8/20.
//

import SwiftUI
import SimpleKeyboard

/// NOTE: doesn't work with `struct` prob. because of copyOnWrite..?
class InputTester: ObservableObject, SimpleKeyboardInput {
    var currentText: String { return text }

    @Published var text: String = ""

    @Published var settings = KeyboardSettings(language: .english, textInput: nil, showNumbers: true, showSpace: true, isUpperCase: false)

    func replaceAll(with text: String) {
        print("UPDATE!")
        self.text = text
    }

    init() { }
}

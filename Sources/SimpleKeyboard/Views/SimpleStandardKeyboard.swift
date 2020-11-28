//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import SwiftUI

public struct SimpleStandardKeyboard: View {
    @Binding var settings: KeyboardSettings

    let bgColor = Color.gray.opacity(0.2)

    public init(settings: Binding<KeyboardSettings>, textInput textInputOverride: Binding<String>? = nil) {
        self._settings = settings

        if let overrideStr = textInputOverride {
            self.settings.changeTextInput(to: overrideStr)
        }
    }

    var spaceRow: some View {
        HStack {
            if settings.showSpace {
                Spacer()
                SpaceKeyButton(text: $settings.text)
                Spacer()
            }
            ActionKeyButton(icon: .done) {
                self.settings.action?()
            }.padding(.trailing, 5)
        }
    }

    var numbersRow: some View {
        HStack(spacing: 10) {
            ForEach(Language.numbers(areUppercased: self.settings.isUpperCase ?? false), id: \.self) { key in
                KeyButton(text: self.$settings.text, letter: key)
            }
        }
    }

    var keyboardRows: some View {
        ForEach(0..<settings.language.rows(areUppercased: settings.isUpperCase ?? false).count, id: \.self) { idx in
            HStack(spacing: 10) {
                if idx == 2 {
                    Spacer()
                    if self.settings.isUpperCase != nil {
                        ShiftKeyButton(isUpperCase: self.$settings.isUpperCase).padding(.leading)
                    }
                }
                self.rowFor(idx)
                if idx == 2 {
                    DeleteKeyButton(text: self.$settings.text)
                        .padding(.trailing)
                    Spacer()
                }
            }
        }
    }

    fileprivate func rowFor(_ index: Int) -> ForEach<[String], String, KeyButton> {
        let rows = self.settings.language.rows(areUppercased: settings.isUpperCase ?? false)[index]
        return ForEach(rows, id: \.self) { key in
            KeyButton(text: self.$settings.text, letter: key)
        }
    }

    public var body: some View {
        VStack(spacing: 10) {
            if settings.showNumbers {
                numbersRow
            }
            keyboardRows
            spaceRow
        }
        .padding(.vertical, 5)
        .background(bgColor)
    }
}

struct SimpleStandardKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        SimpleStandardKeyboard(settings: .constant(KeyboardSettings(language: .english, textInput: nil)))
            .environment(\.locale, .init(identifier: "de"))
    }
}

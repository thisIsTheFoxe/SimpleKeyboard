//
//  SimpleStandardKeyboard.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import SwiftUI

public struct SimpleStandardKeyboard: View, ThemeableView {
    var theme: KeyboardTheme { settings.theme }

    @ObservedObject var settings: KeyboardSettings

    public init(settings: KeyboardSettings, textInput textInputOverride: Binding<String>? = nil) {
        self.settings = settings

        if let overrideStr = textInputOverride {
            self.settings.changeTextInput(to: overrideStr)
        }
    }

    var spaceRow: some View {
        HStack {
            if settings.showSpace {
                SpaceKeyButton(text: $settings.text)
                    .layoutPriority(2)
            }
            if let actionIcon = settings.actionButton {
                ActionKeyButton(icon: actionIcon) {
                    self.settings.action?()
                }
            }
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
            HStack(spacing: 0) {
                if idx == 2 {
                    if self.settings.isUpperCase != nil {
                        ShiftKeyButton(isUpperCase: self.$settings.isUpperCase)
                        Spacer(minLength: 2)
                            .frame(maxWidth: 15)
                            .layoutPriority(2)
                    }
                } else if idx == 1 {
                    Spacer(minLength: 3)
                        .frame(maxWidth: 10)
                        .layoutPriority(11)
                }
                self.rowFor(idx)
                if idx == 2 {
                    Group {
                        Spacer(minLength: 2)
                            .frame(maxWidth: 15)
                            .layoutPriority(2)
                        if settings.language == .french {
                            FRAccentKeyButton(text: $settings.text)
                            Spacer()
                        }
                        DeleteKeyButton(text: self.$settings.text)
                    }
                } else if idx == 1 {
                    Spacer(minLength: 3)
                        .frame(maxWidth: 10)
                        .layoutPriority(11)
                }
            }
        }
    }

    fileprivate func rowFor(_ index: Int) -> some View {
        let rows = self.settings.language.rows(areUppercased: settings.isUpperCase ?? false)[index]
        return ForEach(rows, id: \.self) { key in
            Spacer(minLength: settings.language.spacing)
            KeyButton(text: self.$settings.text, letter: key)
            Spacer(minLength: settings.language.spacing)
        }
    }

    public var body: some View {
        if settings.isShown {
            VStack(spacing: 10) {
                if settings.showNumbers {
                    numbersRow
                        .padding(.bottom, 5)
                }
                keyboardRows
                spaceRow
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .modifier(OuterKeyboardThemingModifier(theme: theme, backroundColor: keyboardBackground))
        }
    }
}

struct SimpleStandardKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.red, .green, .purple], startPoint: .bottomLeading, endPoint: .topTrailing)
            VStack {
                Spacer()
                SimpleStandardKeyboard(
                    settings: KeyboardSettings(
                        language: .english,
                        textInput: nil,
                        theme: .system,
                        actionButton: .search,
                        showNumbers: true,
                        showSpace: true,
                        isUpperCase: true))
                SimpleStandardKeyboard(
                    settings: KeyboardSettings(
                        language: .english,
                        textInput: nil,
                        theme: .system,
                        actionButton: .search,
                        showNumbers: true,
                        showSpace: false,
                        isUpperCase: true))
                    .environment(\.locale, .init(identifier: "ru"))
//                    .preferredColorScheme(.dark)
            }
        }
    }
}

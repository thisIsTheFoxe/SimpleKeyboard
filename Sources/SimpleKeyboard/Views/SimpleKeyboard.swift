//
//  SimpleKeyboard.swift
//
//
//  Created by Henrik Storch on 12/25/19.
//

import SwiftUI

public struct SimpleKeyboard: View, ThemeableView {
    var theme: KeyboardTheme
    var keys: [[String]]
    var actionButton: Icon?
    @Binding var isShown: Bool
    @Binding var text: String
    var action: (() -> Void)?

    public init(
        keys: [[String]],
        textInput: Binding<String>,
        isShown: Binding<Bool> = .constant(true),
        theme: KeyboardTheme = .system,
        actionButton: Icon? = .done,
        action: (() -> Void)? = nil) {
            self.keys = keys
            self.theme = theme
            self._isShown = isShown
            self._text = textInput
            self.action = action
            self.actionButton = actionButton
        }

    var content: some View {
            VStack {
                ForEach(keys, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { key in
                            KeyButton(text: self.$text, letter: key)
                        }
                    }
                }
                HStack {
                    if let actionButton = actionButton {
                        ActionKeyButton(icon: actionButton) {
                            self.action?()
                        }
                    }
                }
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }

    public var body: some View {
        if isShown {
            content.modifier(OuterKeyboardThemingModifier(theme: theme, backroundColor: keyboardBackground))
        }
    }
}

struct SimpleKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(colors: [.red, .green, .purple], startPoint: .bottomLeading, endPoint: .topTrailing)
            VStack {
//                Spacer()
                SimpleKeyboard(
                    keys: [["a", "b", "c", "q", "w", "f", "m", "m"], ["d", "e", "f"]],
                    textInput: .constant(""),
                    theme: .floating,
                    actionButton: .go)
            }
        }
//        .preferredColorScheme(.dark)
    }
}

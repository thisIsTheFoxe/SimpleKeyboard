//
//  KeyButton.swift
//  
//
//  Created by Henrik Storch on 12/24/19.
//

import SwiftUI

protocol ClickableKey {
    func didClick()
}

extension ClickableKey {
    func didClick() {
        #if canImport(UIKit)
        UIDevice.current.playInputClick()
        #endif
    }
}

struct ShiftKeyButton: View {
    @Binding var isUpperCase: Bool!

    var body: some View {
        Button(action: { self.isUpperCase?.toggle() }) {
            if #available(iOS 15, macOS 12, *) {
                AnyView(Image(systemName: isUpperCase ? "shift.fill" : "shift")
                    .dynamicTypeSize(.large))
            } else if #available(iOS 14, macOS 11, *) {
                AnyView(Image(systemName: isUpperCase ? "shift.fill" : "shift"))
            } else {
                AnyView(Text(isUpperCase! ? "Up": "lw", bundle: .module))
            }
        }
        .padding(10)
        .foregroundColor(.primary)
        .font(.headline.weight(.semibold))
        .frame(height: 40)
        .background(Color.black.opacity(0.4))
        .cornerRadius(5)
    }
}

struct KeyButton: View, ClickableKey {
    @Binding var text: String
    var letter: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: {
            self.text.append(self.letter)
            didClick()
        }) {
            Text(letter)
                .font(.system(size: 25))
                .fixedSize()
                .scaledToFit()
                .scaleEffect(0.75)
                .frame(height: 40)
                .frame(minWidth: 20, idealWidth: .infinity, maxWidth: .infinity)
                .foregroundColor(.primary)
                .background(colorScheme.keyboardKeyColor)
                .cornerRadius(5)
                .shadow(color: .black, radius: 0, y: 1)
        }
    }
}

struct FRAccentKeyButton: View {
    @Binding var text: String

    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text("´")
                .foregroundColor(.primary)
                .font(.system(size: 25))
                .padding(5)
                .frame(height: 40)
                .frame(minWidth: 20, idealWidth: 25, maxWidth: 25)
                .background(Color.black.opacity(0.4))
                .cornerRadius(5)
                .layoutPriority(10)
                .shadow(color: .black, radius: 0, y: 1)
        }
    }

    internal func action() {
        var modified = ""
        let suffix = self.text.popLast()
        switch suffix {
        case "a": modified = "à"
        case "e": modified = "é"
        case "i": modified = "î"
        case "u": modified = "û"
        case "o": modified = "ô"
        case "c": modified = "ç"
        default:
            modified = "’"
            if let suffix = suffix {
                self.text.append(suffix)
            }
        }

        text.append(modified)
    }
}

struct SpaceKeyButton: View, ClickableKey {
    @Binding var text: String
    @Environment(\.colorScheme) var colorScheme

    var content: some View {
        let spaceText = Text("space", bundle: .module)
        if #available(iOS 15.0, macOS 12, *) {
            return AnyView(spaceText.dynamicTypeSize(.large))
        } else {
            return AnyView(spaceText)
        }
    }

    var body: some View {
        Button(action: { self.text.append(" "); didClick() }) {
            content
                .padding()
                .frame(idealWidth: .infinity, maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(.primary)
                .background(colorScheme.keyboardKeyColor)
                .cornerRadius(7)
                .layoutPriority(2)
                .shadow(color: .black, radius: 1, y: 1)
        }
    }
}

struct DeleteKeyButton: View {
    @Binding var text: String

    var body: some View {
        Button(action: {
            guard !self.text.isEmpty else { return }
            _ = self.text.removeLast()
        }) {
            if #available(iOS 15, macOS 12, *) {
                AnyView(Image(systemName: "delete.left").dynamicTypeSize(.large))
            } else if #available(iOS 14, macOS 11, *) {
                AnyView(Image(systemName: "delete.left"))
            } else {
                AnyView(Text("⌫"))
            }
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 7)
                .stroke(Color.primary, lineWidth: 4)
        )
        .foregroundColor(.primary)
        .frame(height: 40)
        .font(Font.headline.weight(.semibold))
        .background(Color.black.opacity(0.4))
        .cornerRadius(7)
    }
}

struct ActionKeyButton: View {
    @State var icon: Icon
    var action: () -> Void

    var iconView: some View {
        if #available(iOS 15.0, macOS 12, *) {
            return AnyView(icon.view.dynamicTypeSize(.large))
        } else {
            return icon.view
        }
    }

    var body: some View {
        Button(action: self.action) {
            iconView
                .padding()
                .frame(minWidth: 100, maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 2, y: 2)
        }
    }
}

public enum Icon {
    case done, search, go

    var view: some View {
        switch self {
        case .done: return AnyView(Text("Done!", bundle: .module))
        case .search:
            if #available(iOS 14, macOS 11, *) {
                return AnyView(Image(systemName: "magnifyingglass"))
            }else {
                return AnyView(Text("Search", bundle: .module))
            }
        case .go: return AnyView(Text("Go!", bundle: .module))
        }
    }
}

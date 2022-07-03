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
            if #available(iOS 14, macOS 11, *) {
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

    var body: some View {
        Button(action: { self.text.append(" "); didClick() }) {
            Text("space", bundle: .module)
                .padding()
                .frame(height: 50)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity)
                .background(colorScheme.keyboardKeyColor)
                .cornerRadius(7)
                .layoutPriority(2)
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
            if #available(iOS 14, macOS 11, *) {
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

    var body: some View {
        Button(action: self.action) {
            icon.view.padding()
                .frame(height: 50)
                .foregroundColor(.white)
                .frame(minWidth: 100, idealWidth: .infinity, maxWidth: .infinity)
                .background(Color.blue).cornerRadius(7)
        }
    }
}

enum Icon {
    case done, search, go

    var view: some View {
        switch self {
        case .done: return AnyView(Text("Done!", bundle: .module))
        case .search:
            #if !targetEnvironment(macCatalyst)
            return AnyView(Text("Search", bundle: .module))
            #else
            return AnyView(Image(systemName: "magnifyingglass"))
            #endif
        case .go: return AnyView(Text("Go!", bundle: .module))
        }
    }
}

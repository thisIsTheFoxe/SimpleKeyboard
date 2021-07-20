//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/24/19.
//

import SwiftUI

struct ShiftKeyButton: View {
    @Binding var isUpperCase: Bool!

    var body: some View {
        AnyView(Button(action: { self.isUpperCase?.toggle() }) { () -> AnyView in
            #if !targetEnvironment(macCatalyst)
            return AnyView(Text(isUpperCase! ? "Up": "lw", bundle: .module))
            #else
            return AnyView(Image(systemName: isUpperCase ? "shift.fill" : "shift").imageScale(.large))
            #endif
        })
        .foregroundColor(.primary)
        .font(Font.headline.weight(.semibold))
        .padding()
        .background(Color.gray.opacity(0.5))
        .cornerRadius(5)
    }
}

struct KeyButton: View {
    @Binding var text: String
    var letter: String

    var body: some View {
        Button(action: { self.text.append(self.letter) }) {
            Text(letter)
                .foregroundColor(.primary)
                .font(.system(size: 25))
                .padding(5)
                .frame(minWidth: 25, maxWidth: 50)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(5)
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
                .frame(minWidth: 25, maxWidth: 50)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(5)
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

struct SpaceKeyButton: View {
    @Binding var text: String

    var body: some View {
        Button(action: { self.text.append(" ") }) {
            Text("space", bundle: .module)
                .padding()
                .frame(minWidth: 150, maxWidth: .infinity)
                .foregroundColor(.primary)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(7)
        }
    }
}

struct DeleteKeyButton: View {
    @Binding var text: String

    var body: some View{
        Button(action: {
            guard !self.text.isEmpty else { return }
            _ = self.text.removeLast()
        }) {
            Image(systemName: "delete.left")
                .foregroundColor(.primary)
                .imageScale(.large)
                .font(Font.headline.weight(.semibold))
                .padding(9)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(Color.primary, lineWidth: 4)
                )
                .background(Color.gray.opacity(0.5)).cornerRadius(8)
                .shadow(radius: 1)
        }
    }
}

struct ActionKeyButton: View {
    @State var icon: Icon
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            icon.view.padding()
                .foregroundColor(.white)
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

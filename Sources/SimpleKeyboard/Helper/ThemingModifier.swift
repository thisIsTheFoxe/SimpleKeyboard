//
//  ThemingModifier.swift
//  
//
//  Created by Henrik Storch on 24.04.22.
//

import SwiftUI

struct OuterKeyboardThemingModifier: ViewModifier {
    var theme: KeyboardTheme

    func body(content: Content) -> some View {
        if theme == .floating {
            content
                .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
                .padding(10)
                .background(theme.keyboardBackground)
                .cornerRadius(25)
                .padding(10)
        } else {
            content
                .padding(10)
                .background(theme.keyboardBackground)
        }
    }
}

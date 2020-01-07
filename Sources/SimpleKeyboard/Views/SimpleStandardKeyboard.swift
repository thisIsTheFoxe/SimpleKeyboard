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
    
    public init(settings: Binding<KeyboardSettings>, bindingStringOverride: Binding<String>? = nil){
        self._settings = settings

        if let overrideStr = bindingStringOverride {
            self.settings.changeTextInput(to: overrideStr)
        }
    }
    
    var spaceRow: some View{
        HStack{
            if settings.showSpace{
                Spacer()
                SpaceKeyButton(text: $settings.text)
                Spacer()
            }
            ActionKeyButton(icon: .done) {
                //                    self.isShown.toggle()
                self.settings.action?()
            }.padding(.trailing, 5)
        }
    }
    
    var numbersRow: some View{
        HStack(spacing: 10){
            ForEach(Language.numbers, id: \.self){ key in
                KeyButton(text: self.$settings.text, isUpperCase: .constant(false), letter: key)
            }
        }
    }
    
    public var body: some View {
        VStack(spacing: 10){
            if settings.showNumbers {
                numbersRow
            }
            ForEach(0..<settings.language.rows.count, id: \.self){ i in
                HStack(spacing: 10){
                    if i == 2{
                        Spacer()
                        if self.settings.isUpperCase != nil {
                            ShiftKeyButton(isUpperCase: self.$settings.isUpperCase).padding(.leading)
                        }
                    }
                    ForEach(self.settings.language.rows[i], id: \.self){ key in
                        KeyButton(text: self.$settings.text, isUpperCase: self.$settings.isUpperCase, letter: key)
                    }
                    if i == 2{
                        DeleteKeyButton(text: self.$settings.text).padding(.trailing)
                        Spacer()
                    }
                }
            }
            spaceRow
        }
        .padding(.vertical, 5)
        .background(bgColor)
    }
}

//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SimpleStandardKeyboard: View {
    let language: Language
    let showSpace: Bool
    //    let showShift: Bool = true
    //    let showSpecialKeys: Bool = true
    
    @Binding var text: String
    var includeNumbers: Bool
    var action: ()->()
    
    public init(language: Language, withNumbers includeNumbers: Bool, showSpace: Bool = true, text: Binding<String>, action: @escaping ()->()){
        self.language = language
        self.includeNumbers = includeNumbers
        self.showSpace = showSpace
        self._text = text
        //        self._isShown = isShown
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 10){
            if includeNumbers{
                HStack(spacing: 10){
                    ForEach(Language.numbers, id: \.self){ key in
                        KeyButton(text: self.$text, letter: key)
                    }
                }
            }
            ForEach(0..<language.rows.count, id: \.self){ i in
                HStack(spacing: 10){
                    if i == 2{
                        Spacer()
                    }
                    ForEach(self.language.rows[i], id: \.self){ key in
                        KeyButton(text: self.$text, letter: key)
                    }
                    if i == 2{
                        DeleteKeyButton(text: self.$text).padding(.trailing)
                    }
                }
            }
            HStack{
                if showSpace{
                    Spacer()
                    SpaceKeyButton(text: $text)
                    Spacer()
                }
                ActionKeyButton(icon: .done) {
                    //                    self.isShown.toggle()
                    self.action()
                }.padding(.trailing, 5)
            }
        }.padding(.vertical, 5).background(Color.gray.opacity(0.2))
    }
}

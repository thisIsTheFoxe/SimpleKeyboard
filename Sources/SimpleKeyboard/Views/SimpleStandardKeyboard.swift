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
    var action: ()->()
    
    public init(language: Language, showSpace: Bool = true, text: Binding<String>, action: @escaping ()->()){
        self.language = language
        self.showSpace = showSpace
        self._text = text
        //        self._isShown = isShown
        self.action = action
    }
    
    public var body: some View {
        VStack{
            ForEach(0..<language.rows.count, id: \.self){ i in
                HStack{
                    ForEach(self.language.rows[i], id: \.self){ key in
                        KeyButton(text: self.$text, letter: key)
                    }
                    if i == 2{
                        DeleteKeyButton(text: self.$text)
                    }
                }
            }
            HStack{
                if showSpace{
                    SpaceKeyButton(text: $text)
                }
                ActionKeyButton(icon: .done) {
                    //                    self.isShown.toggle()
                    self.action()
                }
            }
        }
    }
}

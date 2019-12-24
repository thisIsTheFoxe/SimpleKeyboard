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
    let showSpace: Bool = true
    //    let showShift: Bool = true
    //    let showSpecialKeys: Bool = true
    
    @Binding var text: String
    @Binding var isShown : Bool
    var action: ()->()
    
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
                    self.isShown.toggle()
                    self.action()
                }
            }
        }
    }
}

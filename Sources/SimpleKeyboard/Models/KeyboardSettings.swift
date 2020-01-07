//
//  KeyboardSettings.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import Combine

public protocol SimpleKeyboardInput {
    func replaceALl(with text: String)
}

#if canImport(AppKit)
import AppKit
extension NSTextField: SimpleKeyboardInput{
    public func replaceALl(with text: String){
        stringValue = text
    }
}
#elseif canImport(UIKit)
import UIKit
extension UITextInput where Self: SimpleKeyboardInput{
    public func replaceALl(with text: String){
        let b = beginningOfDocument
        let e = endOfDocument
        replace(textRange(from: b, to: e)!, withText: text)
    }
}
#endif

public class KeyboardSettings: ObservableObject {
    public var text: String = "" {
        didSet{
            textInput.replaceALl(with: text)
        }
    }

    public var language: Language
    public var textInput: SimpleKeyboardInput
    public var action: ()->()

    public init(language: Language, textInput: SimpleKeyboardInput, action: @escaping ()->()){
        self.textInput = textInput
        self.language = language
        self.action = action
    }
}

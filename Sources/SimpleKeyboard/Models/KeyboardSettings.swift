//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import UIKit
import Combine

extension UITextInput{
    func replaceALl(with text: String){
        let b = beginningOfDocument
        let e = endOfDocument
        replace(textRange(from: b, to: e)!, withText: text)
    }
}

@available(iOS 13.0, *)
public class KeyboardSettings: ObservableObject {
    public var text: String = "" {
        didSet{
            textInput.replaceALl(with: text)
        }
    }

    public var language: Language
    public var textInput: UITextInput
    public var action: ()->()

    public init(language: Language, textInput: UITextInput, action: @escaping ()->()){
        self.textInput = textInput
        self.language = language
        self.action = action
    }
}

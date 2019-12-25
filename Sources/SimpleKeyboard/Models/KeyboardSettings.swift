//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import UIKit
import Combine

@available(iOS 13.0, *)
public class KeyboardSettings: ObservableObject {
    public var text: String = "" {
        didSet{
            textInput.text = text
        }
    }

    public var language: Language
    public var textInput: UITextField
    public var action: ()->()

    public init(language: Language, textInput: UITextField, action: @escaping ()->()){
        self.textInput = textInput
        self.language = language
        self.action = action
    }
}

//
//  KeyboardSettings.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import Combine
import SwiftUI


public protocol SimpleKeyboardInput {
    mutating func replaceALl(with text: String)
}

extension Binding: SimpleKeyboardInput where Value == String {
    
    public mutating func replaceALl(with text: String){
        self.wrappedValue = text
        print("mutating func replaceALl = "+self.wrappedValue)
    }
}

#if canImport(AppKit)
import AppKit
extension NSTextField: SimpleKeyboardInput{
    public func replaceALl(with text: String){
        stringValue = text
    }
}
#endif

#if canImport(UIKit)
import UIKit
extension UITextField : SimpleKeyboardInput{
    public func replaceALl(with text: String){
        self.text = text
    }
}
#endif

public class KeyboardSettings: ObservableObject {
    public var text: String = "" {
        didSet{
            textInput?.replaceALl(with: text)
        }
    }
    
    var language: Language
    
    public var textInput: SimpleKeyboardInput?
    public var action: (()->())?
    
    //        self._isShown = isShown
    var showNumbers: Bool
    var showSpace: Bool
    
    ///`nil` mean there is no need to switch, so there will be no shift-key
    var isUpperCase: Bool?{
        willSet{
            print("ay!")
            objectWillChange.send()
        }
    }

    ///`textInput` is not needed / does nothing when working with SwiftUI, for that use the `changeTextInput(to:)` method
    public init(language: Language, textInput: SimpleKeyboardInput?, showNumbers: Bool = false, showSpace: Bool = false, isUpperCase: Bool? = nil, action: (()->())? = nil){
        self.textInput = textInput
        self.language = language
        self.action = action
        self.showNumbers = showNumbers
        self.showSpace = showSpace
        self.isUpperCase = isUpperCase
    }
    
    func changeTextInput(to newInput: SimpleKeyboardInput){
        self.textInput = newInput
        print("changed Input")
    }
}

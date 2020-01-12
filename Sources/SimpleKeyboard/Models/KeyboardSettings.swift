//
//  KeyboardSettings.swift
//  
//
//  Created by Henrik Storch on 12/25/19.
//

import Combine
import SwiftUI


public protocol SimpleKeyboardInput {
    var currentText: String { get }
    mutating func replaceAll(with text: String)
}

extension Binding: SimpleKeyboardInput where Value == String {
    public var currentText: String {
        self.wrappedValue
    }
    
    public mutating func replaceAll(with text: String){
        self.wrappedValue = text
        print("mutating func replaceALl = "+self.wrappedValue)
    }
}

#if canImport(AppKit)
import AppKit
extension NSTextField: SimpleKeyboardInput{
    public var currentText: String {
        self.stringValue
    }
    
    public func replaceAll(with text: String){
        stringValue = text
    }
}
#endif

#if canImport(UIKit)
import UIKit
extension UITextField : SimpleKeyboardInput{
    public var currentText: String {
        self.text ?? ""
    }
    
    public func replaceAll(with text: String){
        self.text = text
    }
}
#endif

public class KeyboardSettings: ObservableObject {
    public var text: String = "" {
        didSet{
            textInput?.replaceAll(with: text)
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

    ///`textInput` should be `nil` when working directly with SwiftUI, in that case you would privide your 'bound' value directly to the keyboard
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
        self.text = newInput.currentText
        print("changed Input")
    }
}

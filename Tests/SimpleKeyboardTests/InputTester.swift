//
//  File.swift
//  
//
//  Created by Henrik Storch on 1/8/20.
//

import Foundation
import SimpleKeyboard

///NOTE: doesn't work with `struct` prob. because of copyOnWrite..?
class InputTester: SimpleKeyboardInput {
    var text: String = ""
    func replaceAll(with text: String){
        print("UPDATE!")
        self.text = text
    }
    init(){}
}

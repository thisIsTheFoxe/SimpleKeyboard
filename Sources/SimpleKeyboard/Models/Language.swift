//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/24/19.
//

import Foundation
public enum Language: CaseIterable {
    static func numbers(areUppercased: Bool) -> [String]{
        return areUppercased ? ["!", "?", ".", "%", "+", "-", "_", "=", "@", "#"] : ["1","2","3","4","5","6","7","8","9","0"]
    }
    case english, german
    
    func rows(areUppercased: Bool) -> [[String]] {
        var r = [[String]]()
        switch self{
        case .english:
            r = [["q","w","e","r","t","y","u","i","o","p"],["a","s","d","f","g","h","j","k","l"],["z","x","c","v","b","n","m"]]
        case .german:
            r = [["q","w","e","r","t","z","u","i","o","p"],["a","s","d","f","g","h","j","k","l"],["y","x","c","v","b","n","m"]]
        }
        if areUppercased {
            r = r.map{ $0.map { $0.uppercased() } }
        }
        return r
    }
}

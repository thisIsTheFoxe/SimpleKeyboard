//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/24/19.
//

import Foundation
enum Language{
    case english, german
    
    var rows: [[String]] {
        switch self{
        case .english:
            return [["q","w","e","r","t","y","u","i","o","p"],["a","s","d","f","g","h","j","k","l"],["z","x","c","v","b","n","m"]]
        case .german:
            return [["q","w","e","r","t","z","u","i","o","p"],["a","s","d","f","g","h","j","k","l"],["y","x","c","v","b","n","m"]]
        }
    }
}

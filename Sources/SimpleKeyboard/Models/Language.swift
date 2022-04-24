//
//  Language.swift
//  
//
//  Created by Henrik Storch on 12/24/19.
//

import Foundation
import CoreGraphics

public enum Language: CaseIterable {
    static func numbers(areUppercased: Bool) -> [String] {
        return areUppercased ? ["!", "?", ".", "%", "+", "-", "_", "=", "@", "#"] :
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    }

    var spacing: CGFloat {
        if let maxRows = self.rows(areUppercased: false).max(by: { $0.count < $1.count })?.count, maxRows < 9 {
            return 5
        }
        return 3
    }

    case english, german, spanish, french, russian, hindi

    func rows(areUppercased: Bool) -> [[String]] {
        var result = [[String]]()
        switch self {
        case .english:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]
        case .german:
            result = [
                ["q", "w", "e", "r", "t", "z", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                ["y", "x", "c", "v", "b", "n", "m"]
            ]
        case .spanish:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ñ"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]
        case .french:
            result = [
                ["a", "z", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["q", "s", "d", "f", "g", "h", "j", "k", "l", "m"],
                ["w", "x", "c", "v", "b", "n"]
            ]
        case .russian:
            result = [
                ["й", "ц", "у", "к", "е", "н", "г", "ш", "щ", "з", "х"],
                ["ф", "ы", "в", "а", "п", "р", "о", "л", "д", "ж", "э"],
                ["я", "ч", "с", "м", "и", "т", "ь", "б", "ю"]
            ]
        case .hindi:
            result = [
                ["ौ", "ै", "ा", "ी", "ू", "ब", "ह", "ग", "द", "ज"],
                ["ो", "े", "्", "ि", "ु", "प", "र", "क", "त", "च"],
                ["ं", "म", "न", "व", "ल", "स", "य"]
            ]
        }

        if areUppercased {
            result = result.map { $0.map { $0.uppercased() } }
        }

        return result
    }
}

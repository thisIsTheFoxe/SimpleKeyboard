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
    case swedish, danish, norwegian, finnish
    
    /// General purpose layout using QWERTY with the common diacritics
    case latinWithAccents

    var alternateKeys: [String: String] {
        switch self {
        case .german: return ["a": "ä", "o": "ö", "u": "ü"]
            // spanish also has ü
        case .spanish: return ["e": "é", "a": "á", "i": "í", "o": "ó", "u": "ú", "n": "ñ"]
        case .french: return ["e": "é", "a": "à", "u": "ù", "i": "î", "o": "ô", "c": "ç"]
            // Nynorsk uses several letters with diacritic signs: é, è, ê, ó, ò, â, and ô. The diacritic signs are not compulsory
            // Danish has no compulsory diacritics, but allows the use of an acute accent. Most often, an accent on e.
        case .danish, .norwegian: return ["e": "é"]
        // Though not in the official alphabet, á is a Swedish (old-fashioned) letter. In native Swedish personal names, ü and è and others are also used.
        case .swedish: return ["a":"á", "u":"ü", "e": "è"]
        case .finnish: return ["s": "š", "z": "ž"]
        case .latinWithAccents:
            
            // 300 = Grave;         301 = Acute;
            // 302 = Circumflex;    303 = Tilde;
            // 308 = Diaeresis;     30A = Ring;
            // 327 = Cedilla;       30C = Caron;
            return [
                "\u{0300}": "\u{0301}",
                "\u{0302}": "\u{0303}",
                "\u{0308}": "\u{030A}",
                "\u{0327}": "\u{030C}",]
        default: return [:]
        }
    }

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
                ["q", "w", "e", "r", "t", "z", "u", "i", "o", "p"], // "ü"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"], // "ö", "ä"],
                ["y", "x", "c", "v", "b", "n", "m"]
            ]
        case .spanish:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ü"],
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
        case .swedish:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "å"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]
        case .danish:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "å"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "æ", "ø"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]
        case .norwegian:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "å"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ö", "ä"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]
        case .finnish:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "å"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "ø", "æ"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]

        case .latinWithAccents:
            result = [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "\u{0300}"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l", "\u{0302}", "\u{0308}"],
                ["z", "x", "c", "v", "b", "n", "m", "\u{0327}"]
            ]
        }

        if areUppercased {
            result = result.map { $0.map {
                let upper = $0.uppercased()
                if $0 != upper { return upper }
                return alternateKeys[$0] ?? $0
            } }
        }

        return result
    }
}

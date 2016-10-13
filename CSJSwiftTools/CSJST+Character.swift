//
//  CSJST+Character.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/24.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit


extension Character {
    
    func unicodeScalarCodePoint() -> Int {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return Int(scalars[scalars.startIndex].value)
    }
    
    ///*
//    func isEmoji() -> Bool {
//        return Character(UnicodeScalar(0x1d000)) <= self && self <= Character(UnicodeScalar(0x1f77f))
//            || Character(UnicodeScalar(0x2100)) <= self && self <= Character(UnicodeScalar(0x26ff))
//    }
    //*/
    
    func isEmoji() -> Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        guard let scalarValue = String(self).unicodeScalars.first?.value else {
            return false
        }
        switch scalarValue {
        case 0x3030, 0x00AE, 0x00A9,// Special Characters
        0x1D000...0x1F77F, // Emoticons
        0x2100...0x27BF, // Misc symbols and Dingbats
        0xFE00...0xFE0F, // Variation Selectors
        0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
            return true
        default:
            return false
        }
    }
}

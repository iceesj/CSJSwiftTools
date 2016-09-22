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
    
    /*
    func isEmoji() -> Bool {
        return Character(UnicodeScalar(0x1d000)) <= self && self <= Character(UnicodeScalar(0x1f77f))
            || Character(UnicodeScalar(0x2100)) <= self && self <= Character(UnicodeScalar(0x26ff))
    }
    */
}

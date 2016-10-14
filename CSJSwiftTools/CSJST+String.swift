//
//  CSJST+String.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension String
{
    public func stringRemovedLastChar()->String
    {
        let last1 = self.characters.index(self.endIndex, offsetBy: -1)
        return self.substring(to: last1)
    }
    
    public func encodeURL() -> URL
    {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!;
    }
    
    ///*
    func matchRegex(_ pattern: String) -> Bool {
        /*
        guard let searchResults = range(of: pattern, options: .regularExpression) else {return false}
        return searchResults.lowerBound == startIndex && searchResults.count == characters.count
        */
        guard let searchResults = range(of: pattern, options: .regularExpression) else {
            return false
        }
        return searchResults.lowerBound == startIndex && searchResults.description.characters.count == characters.count
    }
    
    func isValidPhoneNumber() -> Bool {
        return matchRegex("\\d{11}")
    }
    
    func isNumbers() -> Bool {
        return matchRegex("\\d+")
    }
    
    func isNonEmpty() -> Bool {
        return !String(characters.filter({!$0.isEmoji()})).isEmpty
//        return false
    }
    
    func isUserName() -> Bool {
        return String(characters.filter({$0.isEmoji()})).characters.count <= 0 && characters.count <= 20
//        return false
    }
    
    func isSecureCode() -> Bool {
        return matchRegex("\\d{6}")
    }
    
//    func isEmoji() -> Bool {
    public var containEmoji:Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F, // Emoticons
            0x2100...0x27BF, // Misc symbols and Dingbats
            0xFE00...0xFE0F, // Variation Selectors
            0x1F900...0x1F9FF: // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    public var isEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    //*/
}

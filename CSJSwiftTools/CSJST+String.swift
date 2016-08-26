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
        let last1 = self.endIndex.advancedBy(-1)
        return self.substringToIndex(last1)
    }
    
    public func encodeURL() -> NSURL
    {
        return NSURL(string: self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!;
    }
    
    func matchRegex(pattern: String) -> Bool {
        guard let searchResults = rangeOfString(pattern, options: .RegularExpressionSearch) else {return false}
        return searchResults.startIndex == startIndex && searchResults.count == characters.count
    }
    
    func isValidPhoneNumber() -> Bool {
        return matchRegex("\\d{11}")
    }
    
    func isNumbers() -> Bool {
        return matchRegex("\\d+")
    }
    
    func isNonEmpty() -> Bool {
        return !String(characters.filter({!$0.isEmoji()})).isEmpty
    }
    
    func isUserName() -> Bool {
        return String(characters.filter({$0.isEmoji()})).characters.count <= 0 && characters.count <= 20
    }
    
    func isSecureCode() -> Bool {
        return matchRegex("\\d{6}")
    }
}
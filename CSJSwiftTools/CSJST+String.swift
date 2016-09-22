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
//        guard let searchResults = range(of: pattern, options: .regularExpression) else {return false}
//        return searchResults.lowerBound == startIndex && searchResults.count == characters.count
        return false
    }
    
    func isValidPhoneNumber() -> Bool {
        return matchRegex("\\d{11}")
    }
    
    func isNumbers() -> Bool {
        return matchRegex("\\d+")
    }
    
    func isNonEmpty() -> Bool {
//        return !String(characters.filter({!$0.isEmoji()})).isEmpty
        return false
    }
    
    func isUserName() -> Bool {
//        return String(characters.filter({$0.isEmoji()})).characters.count <= 0 && characters.count <= 20
        return false
    }
    
    func isSecureCode() -> Bool {
        return matchRegex("\\d{6}")
    }
    //*/
}

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
}
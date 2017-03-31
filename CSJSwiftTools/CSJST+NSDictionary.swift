//
//  CSJST+NSDictionary.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension NSDictionary
{
    /**
     返回String
     */
    public func CSJST_JSONString()->String?{
        let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        if data == nil{
            return nil
        }
        let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        return strJson as String?
    }
    
    
    
    
}

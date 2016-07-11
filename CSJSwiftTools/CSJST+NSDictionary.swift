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
        let data = try? NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted)
        if data == nil{
            return nil
        }
        let strJson = NSString(data: data!, encoding: NSUTF8StringEncoding)
        return strJson as? String
    }
    
    
    
    
}
//
//  CSJST+UserDefaults.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension NSUserDefaults
{
    public subscript(key : String) -> AnyObject?
        {
        get
        {
            return NSUserDefaults.standardUserDefaults().objectForKey(key)
        }
        set(newValue)
        {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
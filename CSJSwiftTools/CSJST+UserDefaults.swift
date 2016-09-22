//
//  CSJST+UserDefaults.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension UserDefaults
{
    public subscript(key : String) -> AnyObject?
        {
        get
        {
            return UserDefaults.standard.object(forKey: key) as AnyObject?
        }
        set(newValue)
        {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

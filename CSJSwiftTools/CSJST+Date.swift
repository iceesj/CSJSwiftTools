//
//  CSJST+Date.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

//MARK:日期扩展
public extension NSDate{
    /**
     是不是今天判断
     */
    public func CSJST_isToday() -> Bool{
        let second = Int(NSDate().timeIntervalSince1970) - (Int(NSDate().timeIntervalSince1970) % Int(60*60*24))
        if Int(self.timeIntervalSince1970) > second{
            return true
        }
        else{
            return false
        }
    }
}
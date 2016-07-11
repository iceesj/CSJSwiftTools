//
//  CSJSTContentManager.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

class CSJSTContentManager: NSObject {
    // MARK: Singleton
    static let sharedInstance = CSJSTContentManager()
    
    //用户token
    static var Token: String? {
        get {
            return NSUserDefaults().stringForKey("token") ?? ""
        }
        set {
            setUserDefaultItem(newValue, forKey: "token")
        }
    }
    
    
    private class func setUserDefaultItem(item: String?, forKey key: String) {
        NSUserDefaults().removeObjectForKey(key)
        if let string = item {
            NSUserDefaults().setValue(string, forKeyPath: key)
        }
    }
    

}

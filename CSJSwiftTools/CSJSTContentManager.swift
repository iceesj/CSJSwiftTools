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
            return UserDefaults().string(forKey: "token") ?? ""
        }
        set {
            setUserDefaultItem(newValue, forKey: "token")
        }
    }
    
    
    fileprivate class func setUserDefaultItem(_ item: String?, forKey key: String) {
        UserDefaults().removeObject(forKey: key)
        if let string = item {
            UserDefaults().setValue(string, forKeyPath: key)
//            UserDefaults.standard.synchronize()
        }
    }
    

}

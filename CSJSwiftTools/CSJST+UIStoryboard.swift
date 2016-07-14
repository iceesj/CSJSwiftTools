//
//  CSJST+UIStoryboard.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

//MARK:sb扩展
public extension UIStoryboard{
    //用法：
    //        self.webNav = UIStoryboard.CSJST_initViewControllerWithIdentifier("AJMWebNavViewController") as! AJMWebNavViewController
    /*
     storyboard简便标示跳转
     */
    class func CSJST_initViewControllerWithIdentifier(identifier: String!) -> UIViewController? {
        guard let identifier = identifier else {return nil}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
    
    /**
     可填写storyboard名字的segue跳转
     */
    class func CSJST_initViewControllerWithIdentifier2(storyboardString : String ,identifier: String!) -> UIViewController? {
        guard let identifier = identifier else {return nil}
        let storyboard = UIStoryboard(name: storyboardString, bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
}
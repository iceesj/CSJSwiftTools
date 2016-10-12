//
//  CSJSTNavViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/14.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

class CSJSTNavViewController: UINavigationController , UIGestureRecognizerDelegate {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //解决系统级手势卡死手势返回bug
        self.interactivePopGestureRecognizer?.delegate = self
    }

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        return true
    }
}

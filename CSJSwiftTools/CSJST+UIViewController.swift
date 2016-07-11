//
//  CSJST+UIViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension UIViewController {
    var shouldShowBackButton: Bool {
        get {
            return true
        }
    }
    
    func leftBarButtonTapped(sender: UIBarButtonItem!) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func setupLeftBarButton() {
        if shouldShowBackButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "返回")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(UIViewController.leftBarButtonTapped(_:)))
            navigationItem.hidesBackButton = true
        }
    }
    
    /*
     之前包含的页面
     */
    func contentViewController(index: Int = 0) -> UIViewController {
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController!
        } else if let tabbarController = self as? UITabBarController {
            guard let viewControllers = tabbarController.viewControllers else {return self}
            return viewControllers[index].contentViewController(index)
        }
        return self
    }
    
    /*
     弹出登录页
     */
    func promptLoginViewController() {
        let loginNavigationController = UIStoryboard.CSJST_initViewControllerWithIdentifier("")!
        presentViewController(loginNavigationController, animated: true, completion: nil)
    }
    
    
}
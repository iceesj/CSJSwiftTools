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
    
    /**
     初始化VC，颜色，是否layout.None，标题设置
     */
    func initCSJSTSetVC(color: UIColor, bool :Bool, title:String) {
        self.view.backgroundColor = .whiteColor()
        //是否layout展示
        if bool == true {
            edgesForExtendedLayout = .None
        }else{
            
        }
        /**bar的文字*/
        self.navigationItem.title = title
        
    }
    
    
    //MARK: 文字
    /**
     navigationBar右键文字
     */
    /*
    var show_csjst_nav右键文字: Bool {
        get{
            return true
        }
    }
    */
    func csjst_nav右键文字(右键: String){
//        if show_csjst_nav右键文字 {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: 右键, style: .Done, target: self, action: #selector(self.csjst_右键文字(_:)))
//        }
    }
    func csjst_右键文字(sender: UIBarButtonItem){}
    
    /********************************************************************************************************************/
    /**
     navigationBar左键文字
     */
    func csjst_nav左键文字(左键: String){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: 左键, style: .Done, target: self, action: #selector(self.csjst_左键文字(_:)))
    }
    func csjst_左键文字(sender: UIBarButtonItem){}
    /********************************************************************************************************************/
    
    
    //MARK：图片
    /**navigationBar右键图片*/
    func csjst_nav右键图片(右键: String){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: 右键)?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(self.csjst_右键图片(_:)))
    }
    func csjst_右键图片(sender: UIBarButtonItem){}
        
    /**navigationBar左键图片*/
    func csjst_nav左键图片(左键: String){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: 左键)?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(self.csjst_左键图片(_:)))
//        navigationItem.hidesBackButton = true
    }
    func csjst_左键图片(sender: UIBarButtonItem){}
    
    
    /**
     返回按钮图片 - 固定
     */
    func leftBarButtonTapped(sender: UIBarButtonItem!) {
        navigationController?.popViewControllerAnimated(true)
    }

    func setupLeftBarButton() {
        if shouldShowBackButton {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "返回")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(UIViewController.leftBarButtonTapped(_:)))
//            navigationItem.hidesBackButton = true
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
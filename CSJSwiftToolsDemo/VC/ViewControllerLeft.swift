//
//  ViewControllerLeft.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/14.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

class ViewControllerLeft: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLeftBarButton()
        self.initCSJSTSetVC(.whiteColor(), bool: true, title: "左边界面")
        
        
    }

    @IBAction func alertViewQueding(sender: AnyObject) {
//        CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View("单个确定", message: "")
        CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View(self, title: "单个确定", message: "") { (quedingString) in
            
        }
    }
    
    
    @IBAction func alertViewTwo(sender: AnyObject) {
        CSJSwiftToolsDirector.sharedInstance.ui_showAlertVC(self, title: "nicai", message: "",block: { (quedingString) in
            print("确定按钮 返回作用")
            self.navigationController?.popViewControllerAnimated(true)
        }) { (quxiaoString) in
            print("取消按钮 无作用")
        }
    }
    
    @IBAction func actionSheet(sender: AnyObject) {
        CSJSwiftToolsDirector.sharedInstance.ui_showActionSheet(self, title: "nicai2", message: "", block: { (quedingString) in
            print("确定按钮")
            CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View(self, title: "点击了确定", message: "", block: { (quedingString) in
                
            })
//            CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View("点击了确定", message: "")
        }) { (quxiaoString) in
            print("取消按钮")
        }
    }
    

}




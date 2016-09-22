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
        self.initCSJSTSetVC(UIColor.white, bool: true, title: "左边界面")
        
        let old = [1,2,3]
        let new = [1,2,4,5]
        let new1 = Set(new).subtract(old)
        let new2 = new.subtract(old)
        print("old = \(old),new = \(new),new1 = \(new1),new2 = \(new2)")
        
    }

    @IBAction func alertViewQueding(_ sender: AnyObject) {
//        CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View("单个确定", message: "")
        CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View(self, title: "单个确定", message: "") { (quedingString) in
            
        }
    }
    
    
    @IBAction func alertViewTwo(_ sender: AnyObject) {
        CSJSwiftToolsDirector.sharedInstance.ui_showAlertVC(self, title: "nicai", message: "",block: { (quedingString) in
            print("确定按钮 返回作用")
            let _ = self.navigationController?.popViewController(animated: true)
        }) { (quxiaoString) in
            print("取消按钮 无作用")
        }
    }
    
    @IBAction func actionSheet(_ sender: AnyObject) {
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


/**求差(差异)操作*/
extension Collection where Iterator.Element: Hashable {
    /// 返回一个新数组,该数组中的元素存在于 `self` 中,但是不存在于 `toRemove` 里
    func subtract(_ toRemove: [Iterator.Element]) -> [Iterator.Element] {
        let removeSet = Set(toRemove)
        return self.filter {
            !removeSet.contains($0)
        }
    }
}

extension Sequence {
    
}









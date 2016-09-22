//
//  CSJSnapKitDemoSecondViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/3.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

class CSJSnapKitDemoSecondViewController: UIViewController {
    
    let oneView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    let twoView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    let threeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    let fourView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        return view
    }()
    let fiveView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    
    //判断String
    var panduanString : String!
    /*********************************************/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.white
        navigationItem.title = "SnapKit"
        
        view.addSubview(oneView)
        view.addSubview(twoView)
        view.addSubview(threeView)
        view.addSubview(fourView)
        view.addSubview(fiveView)
        
        let padding : CGFloat = 15
        
        if self.panduanString == "1" {
            self.oneView.snp.makeConstraints({ (make) in
                make.top.left.equalTo(padding)
                make.right.bottom.equalTo(-padding)
            })
        }
        else if self.panduanString == "2"{
            //上下
            self.oneView.snp.makeConstraints({ (make) in
                make.top.left.equalTo(padding)
                make.right.equalTo(-padding)
                make.bottom.equalTo(self.twoView.snp.top).offset(-padding)
            })
            
            self.twoView.snp.makeConstraints({ (make) in
                make.left.equalTo(padding)
                make.right.equalTo(-padding)
                make.bottom.equalTo(-padding)
                
                make.width.equalTo(self.oneView.snp.width)
                make.height.equalTo(self.oneView.snp.height)
                
            })
        }
        else if self.panduanString == "3"{
            //3
            self.oneView.snp.makeConstraints({ (make) in
                make.left.top.equalTo(padding)
                make.right.equalTo(-padding)
                make.bottom.equalTo(self.twoView.snp.top).offset(-padding)
                
            })
            self.twoView.snp.makeConstraints({ (make) in
                make.left.equalTo(padding)
                make.right.equalTo(-padding)
                make.bottom.equalTo(self.threeView.snp.top).offset(-padding)
                
                make.width.equalTo(self.oneView.snp.width)
                make.height.equalTo(self.oneView.snp.height)
                
            })
            self.threeView.snp.makeConstraints({ (make) in
                make.left.equalTo(padding)
                make.right.bottom.equalTo(-padding)
                
                make.width.equalTo(self.oneView.snp.width)
                make.height.equalTo(self.oneView.snp.height)
            })
        }
        else if self.panduanString == "4"{
            CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View(self, title: "正在开发", message: "", block: { (quedingString) in
                CSJSwiftToolsDirector.sharedInstance.ui_backToLastVC(self.view)
            })
        }
        else{
            CSJSwiftToolsDirector.sharedInstance.ui_showAlert确定View(self, title: "正在开发", message: "", block: { (quedingString) in
                CSJSwiftToolsDirector.sharedInstance.ui_backToLastVC(self.view)
            })
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

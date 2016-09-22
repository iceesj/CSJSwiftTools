//
//  ViewController2.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/14.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import FDStackView

//csjstackview
class ViewController2: UIViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //开关 可不设置
//    override var show_csjst_nav右键文字: Bool { get { return true } }
//    override var show_csjst_nav左键文字: Bool { get { return false } }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.white
        edgesForExtendedLayout = UIRectEdge()
        self.navigationItem.title = "VC2"
        
//        self.initCSJSTSetVC(.redColor(), bool: true, title: "VC2")
//        self.csjst_nav右键图片("Enhance")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Enhance")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.csjst_右键图片(_:)))

        
        self.setupLeftBarButton()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.csjst_nav右键图片("Enhance")
//        self.setupLeftBarButton()
    }
    
    
    override func csjst_右键图片(_ sender: UIBarButtonItem) {
        print("图片点击")
        
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

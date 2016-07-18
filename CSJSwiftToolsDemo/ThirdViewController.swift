//
//  ThirdViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/18.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initCSJSTSetVC(.whiteColor(), bool: true, title: "界面三")
        
        
        
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

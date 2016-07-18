//
//  ViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJExtension
import Alamofire

//主页
class ViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.initCSJSTSetVC(.whiteColor(), bool: true, title: "界面一")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //直接添加返回
//        self.setupLeftBarButton()
//        self.view.backgroundColor = .whiteColor()
//        edgesForExtendedLayout = .None
//        self.navigationItem.title = "item"
        
        
        //MARK:时间截取转换
        let lastTimeValueName_Two : String = CSJSwiftToolsDirector.sharedInstance.fengeTime("17:30-18:00").string2
        let lastTimeValueNameTwoInt : Int = CSJSwiftToolsDirector.sharedInstance.zhuanhuanShiduanInt(lastTimeValueName_Two)
        print("lastTimeValueNameTwoInt = \(lastTimeValueNameTwoInt)")

        
        //MARK:changeHight
        let headerIMG : UIImageView = UIImageView()
        headerIMG.backgroundColor = .redColor()
        headerIMG.frame = CGRectMake(50 , 50, 50, CSJSwiftToolsDirector.sharedInstance.changeHight(40)!)
        view.addSubview(headerIMG)
        
        //MARK:convertStringToDictionary
        //fake JSON，假的JSON
        let dd : NSDictionary = ["functionName": "getCurrentPosition","data":"定位出错"]
        let data = dd.mj_JSONString()
        let dict = CSJSwiftToolsDirector.sharedInstance.convertStringToDictionary(data)
        print("dict = \(dict!)")
        
        //MARK:自定义分割
        let stringFENGGETest : String = CSJSwiftToolsDirector.sharedInstance.fengeStringCOMMON("你好~~再见", "~~").string2
        print("自定义截取字 = \(stringFENGGETest)")
        
        self.csjst_nav右键文字("右键跳转")
        self.csjst_nav左键文字("警告窗口")
        
        //csj点击
        headerIMG.userInteractionEnabled = true
        let thisViewTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.headerIMGTap) )
        headerIMG.addGestureRecognizer(thisViewTap)
        
        
        self.requestOne()
        
        
    }
    
    func headerIMGTap(){
        print("点击")
    }
    

    override func csjst_右键文字(sender: UIBarButtonItem){
//        if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
//        print("self.navigationController = \(self.navigationController)")
//        print("123 = \(self.navigationController?.interactivePopGestureRecognizer?.enabled)")
//        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
//        print("321 = \(self.navigationController?.interactivePopGestureRecognizer?.enabled)")
//        }
        let vc2 = UIStoryboard.CSJST_initViewControllerWithIdentifier("ViewController2") as! ViewController2
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    
    override func csjst_左键文字(sender: UIBarButtonItem){
        let vcLeft = UIStoryboard.CSJST_initViewControllerWithIdentifier("ViewControllerLeft") as! ViewControllerLeft
        vcLeft.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vcLeft, animated: true)
        
        
    }
    
    func requestOne() {
        let parameters = ["phone":"13611111111","messageNumber":"123456"]
        CSJSTNetworkManager.sharedInstance.loginMima(parameters) { (json, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if error == nil, let json = json {
                    print("json = \(json)")
                    
                }
                else{
                    print("Login failed: \(json) \(error)")
                }
            }
            
        }
        
    }
    
    
    
    
}







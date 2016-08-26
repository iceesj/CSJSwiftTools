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

import RxCocoa
import RxSwift

//主页
class ViewController: UIViewController {
    
    @IBOutlet weak var textfield1 : UITextField!
    @IBOutlet weak var label1 : UILabel!
    let disposeBag = DisposeBag()

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
        
        //MARK:时间戳
        let shijian = CSJSwiftToolsDirector.shijianChuo_10Num()
        print("10位时间戳 = \(shijian)")
        let shijian13 = CSJSwiftToolsDirector.shijianChuo_13Num()
        print("13位时间戳 = \(shijian13)")
        
        
        
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
        
//        self.requestFromData()
        
//        self.requestJSON()
        
        let testArray = [1,2,3]
        for i in 0...testArray.count {
            print("i = \(i)")
        }
        
        
        textfield1.backgroundColor = .blackColor()
        label1.backgroundColor = .blackColor()
        textfield1.textColor = .whiteColor()
        label1.textColor = .whiteColor()
        textfield1.rx_text.bindTo(label1.rx_text).addDisposableTo(disposeBag)
        
        
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
    
    
    /**
     POST JSON，Back JSON
     */
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
    
    /**
     POST Form-data， Back JSON
     */
    func requestFromData() {
        let body = [
            "tradeId":"20160623142414796650971207862444",
            "device":"pc",
            "sessionId":"b3c8e4bd-dd36-4fbb-985d-c61b48e6be2d",
            "channel":"WECHAT_APP",
            "version":"1.0.0",
            ]
        
        CSJSTNetworkManager.sharedInstance.sendRequest2(body) { (json, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if error == nil, let json = json {
                    print("json = \(json)")
                }
                else{
                    print("Login failed: \(json) \(error)")
                }
            }
        }
        /*
        CSJSTNetworkManager.sharedInstance.sendRequest(body) { (json, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if error == nil, let json = json {
                    print("json = \(json)")
                    
                }
                else{
                    print("Login failed: \(json) \(error)")
                }
            }
        }
        */
    }
    
    
    
    //MARK：popanimation
    @IBAction func popanimation_click(sender: AnyObject) {
        let vc : POPTableviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("POPTableviewViewController") as! POPTableviewViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Realm
    @IBAction func realmdemo_click(sender: AnyObject) {
        let vc : RealmTableviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RealmTableviewViewController") as! RealmTableviewViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func viewmodelTableview_click(sender: AnyObject) {
        print("viewmodelTableview")
        let vc : BaomingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("BaomingViewController") as! BaomingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    /************************** 我是分割线 ****************************/
    
    /**
    单例一个 傻瓜式的Alamofire请求返回
     */
    func requestJSON() {
        let body = [
            "phone": "13611111111",
            "messageNumber": "123456"
        ]
        
        CSJSTNetworkManager.sharedInstance.sendRequest_JSON(body) { (json, error) in
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







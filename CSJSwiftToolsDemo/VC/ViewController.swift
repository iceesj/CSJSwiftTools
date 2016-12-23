//
//  ViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

//import Foundation
//import UIKit
import SwiftyJSON
import MJExtension
import SVProgressHUD

import RxCocoa
import RxSwift

//import Alamofire

//主页
class ViewController: UIViewController {
    
    @IBOutlet weak var textfield1 : UITextField!
    
    @IBOutlet weak var label1 : UILabel!
    
    @IBOutlet weak var label2 : UILabel!
    
    var disposeBag = DisposeBag()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initCSJSTSetVC(UIColor.white, bool: true, title: "界面一")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //直接添加返回
        self.setupLeftBarButton()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge()
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
        
        self.navigationItem.title = "item"
        
        //MARK:时间戳
        let shijian = CSJSwiftToolsDirector.shijianChuo_10Num()
        print("10位时间戳 = \(shijian)")
//        let shijian13 = CSJSwiftToolsDirector.shijianChuo_13Num()
//        print("13位时间戳 = \(shijian13)")
        
        //MARK:时间截取转换
        let lastTimeValueName_Two : String = CSJSwiftToolsDirector.sharedInstance.fengeTime("17:30-18:00").string2!
        let lastTimeValueNameTwoInt : Int = CSJSwiftToolsDirector.sharedInstance.zhuanhuanShiduanInt(lastTimeValueName_Two)
        print("lastTimeValueNameTwoInt = \(lastTimeValueNameTwoInt)")

        
        //MARK:changeHight
        let headerIMG : UIImageView = UIImageView()
        headerIMG.backgroundColor = UIColor.red
        headerIMG.frame = CGRect(x: 50 , y: 50, width: 50, height: CSJSwiftToolsDirector.sharedInstance.changeHight(40)!)
        view.addSubview(headerIMG)
        
        //MARK:convertStringToDictionary
        //fake JSON，假的JSON
        let dd : NSDictionary = ["functionName": "getCurrentPosition","data":"定位出错"]
        let data = dd.mj_JSONString()
        let dict = CSJSwiftToolsDirector.sharedInstance.convertStringToDictionary(data!)
        print("dict = \(dict!)")
        
        //MARK:自定义分割
        let stringFENGGETest : String = CSJSwiftToolsDirector.sharedInstance.fengeStringCOMMON("你好~~再见", "~~").string2!
        print("自定义截取字 = \(stringFENGGETest)")
        
        self.csjst_nav右键文字("右键跳转")
        self.csjst_nav左键文字("警告窗口")
        
        //csj点击
        headerIMG.isUserInteractionEnabled = true
        let thisViewTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.headerIMGTap) )
        headerIMG.addGestureRecognizer(thisViewTap)
        
        
//        self.alamofireiOS9Test()
        
        self.postJSON()
        
//        self.getFormdata()
        
//        self.postFromData()
        
//        self.requestJSON()
        
        let testArray = [1,2,3]
        for i in 0...testArray.count {
            print("i = \(i)")
        }
        
        
        textfield1.backgroundColor = UIColor.black
        label1.backgroundColor = UIColor.blue
        textfield1.textColor = UIColor.white
        label1.textColor = UIColor.black
        
        textfield1.rx.text.bindTo(label1.rx.text).addDisposableTo(disposeBag)
        
        
        //替换
        let tihuan = "?? nihao //"
        let tihuanChangeString = CSJSwiftToolsDirector.sharedInstance.stringTihuan(tihuan, "?", "/")
        print("替换测试 = \(tihuanChangeString)")
        
        //过滤
        let guolv = "?? nihao //"
        let guolvChangeString = CSJSwiftToolsDirector.sharedInstance.stringGuolv(guolv, "??")
        print("过滤测试 = \(guolvChangeString)")
        
        //切割
        let qiege = "ni/hao/zai/jian"
        let qiegeArray = CSJSwiftToolsDirector.sharedInstance.stringQiege(qiege, "/")
        let qiege_one = qiegeArray[0]
        print("nihao_one = \(qiege_one)")
        
        //拼接
        let pingjie = ["1","2","3"]
        let pingjieString = CSJSwiftToolsDirector.sharedInstance.arrayChangeString(pingjie)
        print("pingjieString = \(pingjieString)")
        
        
        //判断表情
        let textString = "🆚"
        if textString.containEmoji == true {
            print("是表情")
        }else{
            print("不是表情")
        }
        
        //判断Email
        let emailString = "123@163.com"
        if emailString.isEmail == true {
            print("是Email")
        }else{
            print("不是Email")
        }
        
        
    }
    
    func headerIMGTap(){
        print("点击")
    }
    

    override func csjst_右键文字(_ sender: UIBarButtonItem){
//        if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
//        print("self.navigationController = \(self.navigationController)")
//        print("123 = \(self.navigationController?.interactivePopGestureRecognizer?.enabled)")
//        self.navigationController?.interactivePopGestureRecognizer?.enabled = false
//        print("321 = \(self.navigationController?.interactivePopGestureRecognizer?.enabled)")
//        }
        let vc2 = UIStoryboard.CSJST_initViewControllerWithIdentifier("ViewController2") as! ViewController2
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    
    override func csjst_左键文字(_ sender: UIBarButtonItem){
        let vcLeft = UIStoryboard.CSJST_initViewControllerWithIdentifier("ViewControllerLeft") as! ViewControllerLeft
        vcLeft.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vcLeft, animated: true)
        
        
    }
    
    
    //alamofire
    /*
    func alamofireiOS9Test() {
        CSJAlamofire.sharedInstance.postJSON("https://front.bestfood520.com/api-front/", .post, [:]) { (json, error) in
            if error == nil, let json = json {
                print("alamofire json = \(json)")
                
            }else{
                print("error = ")
            }
        }
    }
    */
    
    /**
     POST JSON，Back JS、ON
     */
    func postJSON() {
        CSJSTNetworkManager.sharedInstance.getURLParams("/api-front/application/current-front-ios-version", [:]) { (swiftyJsonVar, error) in
            print("string = \(error), 返回的json = \(swiftyJsonVar)")
            //返回的Dict
            let status = swiftyJsonVar["status"].stringValue
            print("error = \(error)")
            //弹出错误
            guard error == nil else{
                SVProgressHUD.showError(withStatus: "网络有点问题，请稍后再尝试")
                return
            }
            guard status != "ERROR" else{
                print("是错误")
                SVProgressHUD.showError(withStatus: "\(swiftyJsonVar["message"].stringValue)")
                return
            }
            
            let resultDic = swiftyJsonVar["result"].dictionaryValue
            print("resultDic = \(resultDic)")
        }
        
    }
    
    
    /**
     GET Form-data， Back JSON, has Params
    **/
    
    func getFormdata() {
        let body =  [
            "sessionId": "569b773b-5c5e-42a1-bbcd-8ed36bd301f3",
            "version": "1.0.0",
            "device": "pc",
            ]
        
        CSJSTNetworkManager.sharedInstance.getURLParams("/api-front/session/get-user-info", body)
        { (swiftyJsonVar, error) in
            print("string = \(error), 返回的json = \(swiftyJsonVar)")
            //返回的Dict
            let status = swiftyJsonVar["status"].stringValue
            
            //弹出错误
            guard status != "ERROR" else{
                print("是错误")
                SVProgressHUD.showError(withStatus: "\(swiftyJsonVar["message"].stringValue)")
                return
            }
            
            let resultDic = swiftyJsonVar["result"].dictionaryValue
            print("resultDic = \(resultDic)")
            
        }
        
        
    }
    
    
    /**
     POST Form-data， Back JSON
     */
    func postFromData() {
        //POST 无参数
        let body = ["123":123]
        CSJSTNetworkManager.sharedInstance.postURLParamsOnly("/api-front/session/create", body) { (swiftyJsonVar, error) in
            let status = swiftyJsonVar["status"].stringValue
            guard status != "ERROR" else{
                print("是错误")
                SVProgressHUD.showError(withStatus: "\(swiftyJsonVar["message"].stringValue)")
                return
            }
            let resultDic = swiftyJsonVar["result"].stringValue
            print("resultDic = \(resultDic)")
            
        }
        
        
        //POST 有参数
        let URLParams = [
            "phoneNumber": "18621282315",
            "password": "1",
            "sessionId": "9ffc6613-344a-436a-bfa8-6a6fa603b303",
            "version": "1.0.0",
            "device": "pc",
            ]
        CSJSTNetworkManager.sharedInstance.postURLParams("/api-front/session/login-with-password", URLParams) { (swiftyJsonVar, error) in
            let status = swiftyJsonVar["status"].stringValue
            guard status != "ERROR" else{
                print("是错误")
                SVProgressHUD.showError(withStatus: "\(swiftyJsonVar["message"].stringValue)")
                return
            }
            let resultDic = swiftyJsonVar["result"].dictionaryValue
            print("resultDic = \(resultDic)")
            
        }
        
        /*
        let body = [
            "tradeId":"20160623142414796650971207862444",
            "device":"pc",
            "sessionId":"b3c8e4bd-dd36-4fbb-985d-c61b48e6be2d",
            "channel":"WECHAT_APP",
            "version":"1.0.0",
            ]
        
        CSJSTNetworkManager.sharedInstance.sendRequest2(body) { (json, error) in
            DispatchQueue.main.async {
                if error == nil, let json = json {
                    print("json = \(json)")
                }
                else{
                    print("Login failed: \(json) \(error)")
                }
            }
        }
        */
        
        
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
    @IBAction func popanimation_click(_ sender: AnyObject) {
        let vc : POPTableviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "POPTableviewViewController") as! POPTableviewViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Realm
    @IBAction func realmdemo_click(_ sender: AnyObject) {
        let vc : RealmTableviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "RealmTableviewViewController") as! RealmTableviewViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func viewmodelTableview_click(_ sender: AnyObject) {
        print("viewmodelTableview")
        let vc : BaomingViewController = self.storyboard?.instantiateViewController(withIdentifier: "BaomingViewController") as! BaomingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    /************************** 我是分割线 ****************************/
    
    /**
    单例一个 傻瓜式的Alamofire请求返回
     */
    func requestJSON() {
        //Alamofire 4
        /*
        Alamofire.request("", method: .post, parameters: [:], encoding: JSONEncoding.default)
            .responseJSON { response in
                let (response, result) = (response.response, response.result)
                let statusCode = response?.statusCode ?? 404
//                if (response.result.error == nil) {
//                }
                if case (200..<300) = statusCode {
                    print("alamofire 成功请求Code = \(statusCode)")
                    let value = result.value ?? Data()
                    let json = JSON(value)
                    print("swiftyJsonVar = \(json)")
                } else {
                    print("statusCode = \(statusCode)")
                    
                }
        }
        */
        
        //Alamofire 3
        /*
        Alamofire.request("", withMethod: .post ,parameters: nil, encoding: .json, headers: nil)
            .responseJSON { response in
            if (response.result.error == nil) {
                
            }
            else {
                debugPrint("HTTP Request failed: \(response.result.error)")
                print("\(response.response?.statusCode)")
                
            }
        }
        */
        
    }
    
    
    
}







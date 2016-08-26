//
//  BaomingViewController.swift
//  xs1happ
//
//  Created by tom on 16/5/24.
//  Copyright © 2016年 xs1h. All rights reserved.
//

import UIKit
import MBProgressHUD


class BaomingViewController: UIViewController , UITableViewDataSource {
    //方法一
    @IBOutlet weak var headerView : UIView!
    var footerView : UIView!
    var middleView : UIView!
    
    @IBOutlet weak var chakanxiangqing: UILabel!
    
    var mmTransitioningDelegate: UIViewControllerTransitioningDelegate?
    
    var overLayView : UIView!
    var overLayView2 : UIView!//备用
    
    //方法二
    var baomingStatus = BaomingStatus.Login{
        didSet{
            tableView.reloadData()
            print("当前是已登录的")
        }
    }
    
    var loginViewModel = BaomingViewModel()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginButton: UIButton!
    
    //序号
    var xuhaoLabel : UILabel!
    
    //判断注册or登录
    var panduanISZhuce : Bool!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "巴比面点活动报名页"
        self.edgesForExtendedLayout = .None
        
        tableView.scrollEnabled = false
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "返回")?.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: #selector(UIViewController.leftBarButtonTapped(_:)))
        navigationItem.hidesBackButton = true
        
//        self.initView()
        
        self.xuhaoLabel = UILabel()
        self.xuhaoLabel.font = UIFont.systemFontOfSize(14)
        self.xuhaoLabel.textColor = UIColor.grayColor()
        
        self.panduanISZhuce = false
        
        
        self.headerView.userInteractionEnabled = true
        let headerViewTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaomingViewController.headerViewTap) )
        self.headerView.addGestureRecognizer(headerViewTap)
        
        self.addOverLayView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaomingViewController.beginTicker_Item_NC(_:)), name: "beginTicker_Item_NC", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BaomingViewController.AJMNSNotificationCenter_BaomingViewController_Pop), name: "AJMNSNotificationCenter_BaomingViewController_Pop", object: nil)

    }
    
    
    func AJMNSNotificationCenter_BaomingViewController_Pop(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: 通知中心
    func beginTicker_Item_NC(notification : NSNotification){
        let dictString : String = notification.object as! String
        print("string111 = \(dictString)")
        self.xuhaoLabel.text = "序号:\(dictString)"
        //        self.tableView.reloadData()
    }
    
    func headerViewTap(){
        print("查看详情 按钮")
        
//        let vc = BaomingSuccessViewController()
//        self.presentViewController(vc, animated: false,completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        let overlay = OverlayViewController()
//        mmTransitioningDelegate = OverlayTransitioningDelegate()
//        overlay.transitioningDelegate = mmTransitioningDelegate
//        presentViewController(overlay, animated: true, completion: nil)
        
        
        
//        self.overLayView.hidden = false
    }
    
    func initView() {
        self.headerView = UIView()
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH_CSJST, 128)
        self.headerView.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.headerView)
        
    }
    
    func addOverLayView() {
        self.overLayView = UIView()
//        self.overLayView.frame = self.view.frame
        self.overLayView.frame = CGRectMake(0, 0, SCREEN_WIDTH_CSJST, SCREEN_HEIGHT_CSJST)
        self.overLayView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.overLayView.hidden = true
//        self.view.superview!.addSubview(self.overLayView)
        self.navigationController?.view.superview?.addSubview(self.overLayView)
//        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        delegate.webNav.view.superview!.addSubview(self.overLayView)
        
        let img = UIImageView()
        img.frame = CGRectMake(100 , 200, SCREEN_WIDTH_CSJST-200, 100)
//        img.image = UIImage(named: "活动报名弹框")
        img.image = UIImage(named: "恭喜你报名成功")
        self.overLayView.addSubview(img)
        
        
        self.overLayView.userInteractionEnabled = true
        let overLayViewTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaomingViewController.overLayViewTap) )
        self.overLayView.addGestureRecognizer(overLayViewTap)
    }
    
    func overLayViewTap(){
        print("点击")
        self.overLayView.hidden = true
        
        NSNotificationCenter.defaultCenter().postNotificationName("AJMNSNotificationCenter_BaomingViewController_Pop", object: nil)
    }
    
    //提交报名
    @IBAction func loginButtonTapped(sender: UIButton) {
        print("提交报名");
        /*
        if self.panduanISZhuce == true {
            self.panduanISZhuce = false
            self.tableView.reloadData()
        }else{
            self.panduanISZhuce = true
            self.tableView.reloadData()
        }
        */
        
//        view.endEditing(true)
        
        var input = (phone: "", securityCode: "", userName: "", companyName:"")
        print("123 = \(loginViewModel[baomingStatus])")
        
        let AJM_Panduan_BaomingSEX = NSUserDefaults.standardUserDefaults().objectForKey("AJM_Panduan_BaomingSEX") as! String
        print("AJM_Panduan_BaomingSEX = \(AJM_Panduan_BaomingSEX)")
        
        for i in 0 ..< 5 {
            if i == 3{
                print("是性别")
                guard AJM_Panduan_BaomingSEX != "Nomal" else{
                    MBProgressHUD.showWithStatus("请选择性别", onView: self.view)
                    return
                }
            }
            else if i==4 {
                print("是公司")
                let textFieldText = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as? TextCell)?.textFieldText
                input.companyName = textFieldText!
            }
            else{
                let (validator, prompt) = loginViewModel.validator(baomingStatus, i)
                guard let textFieldText = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as? TextCell)?.textFieldText where validator(textFieldText)() else {
                    //                    MBProgressHUD.showWithStatus(prompt, onView: self.view)
                    if prompt == "Error"{
                        if i==2 {
                            MBProgressHUD.showWithStatus("请输入姓名", onView: self.view)
                        }
                        else if i==1 {
                            MBProgressHUD.showWithStatus("请输入短信验证码", onView: self.view)
                        }
                        else{
                            MBProgressHUD.showWithStatus("请完整输入", onView: self.view)
                        }
                    }else{
                        MBProgressHUD.showWithStatus(prompt, onView: self.view)
                    }
                    return
                }
                
                if i == 0 {
                    input.phone = textFieldText
                }
                else if i == 1{
                    input.securityCode = textFieldText
                }
                else{
                    input.userName = textFieldText
                }
            /*
            else{
                input.companyName = textFieldText
            }
            */
            }
            
        }
        
        print("电话 = \(input.phone),验证码 = \(input.securityCode),姓名=\(input.userName), 公司名字=\(input.companyName)，性别=\(AJM_Panduan_BaomingSEX)")
        
        var sexInt : Int  = 0
        if AJM_Panduan_BaomingSEX == "Mon" {
            sexInt = 1
        }else{
            sexInt = 2
        }
        
        let ddZong2 : NSDictionary = ["phone": input.phone,"name":input.userName,"sex":sexInt,"company":input.companyName]
        print("提交的字典 = \(ddZong2)")
        
        /*
        NetworkManager.sharedInstance.SignUpadd(ddZong2, code: input.securityCode) { (json, error) in
            if error == nil, let json = json {
                print("返回的json = \(json)")
                let statusCode = json["statusCode"].stringValue
                if statusCode == "0" {
                    print("提交成功")
//                    MBProgressHUD.showWithStatus("报名成功！", onView: self.view)
//                    CSJHUD.csjtoastCenter("报名成功", time: 2.0)
                    self.overLayView.hidden = false
                    
//                    let time: NSTimeInterval = 2.0
//                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
//                    dispatch_after(delay, dispatch_get_main_queue()) {
//                        print("2 秒后输出")
//                        self.navigationController?.popViewControllerAnimated(true)
//                    }
                }else{
                    print("提交失败")
                    MBProgressHUD.showWithStatus("提交报名出错", onView: self.view)
//                    CSJHUD.csjtoastCenter("提交报名出错", time: 2.0)
                }
            }
            else{
                print("error = \(error!)")
                let errorString = "\(error!)"
                MBProgressHUD.showWithStatus(errorString, onView: self.view)
//                CSJHUD.csjtoastCenter(errorString, time: 2.0)

            }
        }
        */
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let (cellIdentifier, _) = loginViewModel[baomingStatus, indexPath.row],let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
                return UITableViewCell()
        }
        
        
//        if let cell = cell as? TextCell {
//            cell.setupWithPlaceHolder(placeholder)
//        }
        
        //手机号cell
        if let cell = cell as? TextWithButtonCell {
            cell.parentView = view
            cell.setupWithPlaceHolder("请输入手机号")
        }
        
        //输入验证码cell
        if let cell = cell as? TextTwoWithPlaceholderCell {
            cell.textField.secureTextEntry = false
            cell.textField.keyboardType = .NumberPad
            
            self.xuhaoLabel.frame = CGRectMake(SCREEN_WIDTH_CSJST-100, 10, 90, 30)
            self.xuhaoLabel.backgroundColor = UIColor.clearColor()
            cell.contentView.addSubview(self.xuhaoLabel)
//            cell.backgroundColor = UIColor.redColor()
            cell.setupWithPlaceHolder("请输入短信中的验证码")
        }
        
        //名字cell
        if let cell = cell as? TextNameCell {
            cell.setupWithPlaceHolder("请输入姓名")
        }
        
        //公司cell
        if let cell = cell as? TextGSCell {
            cell.setupWithPlaceHolder("请输入公司名称")
        }
        
        
        if let cell = cell as? TextSexCell {
            cell.setupWithCell()
        }
        
        return cell
        
    }
    
    /*
    func xiansheng_normalTap(){
        print("xiansheng_normalTap")
    }
    
    func xiansheng_clickTap(){
        print("先生")
    }
    */
    
}


protocol TextCell: class {
    func setupWithPlaceHolder(placeHolder: String)
    var textFieldText: String? {get}
}

class TextNameCell : UITableViewCell , TextCell {
    
    @IBOutlet weak var textField: UITextField!
    
    func setupWithPlaceHolder(placeholder: String) {
        let style : NSMutableParagraphStyle = textField.defaultTextAttributes[NSParagraphStyleAttributeName]!.mutableCopy() as! NSMutableParagraphStyle
        style.minimumLineHeight = textField.font!.lineHeight - (textField.font!.lineHeight - UIFont.systemFontOfSize(13.0).lineHeight) / 2.0
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [
                NSFontAttributeName: CSJST_GlobalConstants.PlaceholderFont,
                NSForegroundColorAttributeName: CSJST_GlobalConstants.PlaceholderColor,
                NSParagraphStyleAttributeName: style
            ])
        //上线账号
        //        textField.text = "123456"
        textField.text = ""
    }
    var textFieldText: String? {
        get {
            return textField.text
        }
    }
}


class TextGSCell : UITableViewCell , TextCell {
    
    @IBOutlet weak var textField: UITextField!
    
    func setupWithPlaceHolder(placeholder: String) {
        let style : NSMutableParagraphStyle = textField.defaultTextAttributes[NSParagraphStyleAttributeName]!.mutableCopy() as! NSMutableParagraphStyle
        style.minimumLineHeight = textField.font!.lineHeight - (textField.font!.lineHeight - UIFont.systemFontOfSize(13.0).lineHeight) / 2.0
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [
                NSFontAttributeName: CSJST_GlobalConstants.PlaceholderFont,
                NSForegroundColorAttributeName: CSJST_GlobalConstants.PlaceholderColor,
                NSParagraphStyleAttributeName: style
            ])
        //上线账号
        //        textField.text = "123456"
        textField.text = ""
    }
    var textFieldText: String? {
        get {
            return textField.text
        }
    }
}

//
class TextTwoWithPlaceholderCell: UITableViewCell, TextCell {
    
    @IBOutlet weak var textField: UITextField!
    
    func setupWithPlaceHolder(placeholder: String) {
        let style : NSMutableParagraphStyle = textField.defaultTextAttributes[NSParagraphStyleAttributeName]!.mutableCopy() as! NSMutableParagraphStyle
        style.minimumLineHeight = textField.font!.lineHeight - (textField.font!.lineHeight - UIFont.systemFontOfSize(13.0).lineHeight) / 2.0
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [
                NSFontAttributeName: CSJST_GlobalConstants.PlaceholderFont,
                NSForegroundColorAttributeName: CSJST_GlobalConstants.PlaceholderColor,
                NSParagraphStyleAttributeName: style
            ])
        // 上线账号
        //        textField.contentVerticalAlignment = .Center
        textField.text = ""
    }
    func setupWithPlaceHolder2(placeholder: String) {
        let style : NSMutableParagraphStyle = textField.defaultTextAttributes[NSParagraphStyleAttributeName]!.mutableCopy() as! NSMutableParagraphStyle
        style.minimumLineHeight = textField.font!.lineHeight - (textField.font!.lineHeight - UIFont.systemFontOfSize(13.0).lineHeight) / 2.0
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
            [
                NSFontAttributeName: CSJST_GlobalConstants.PlaceholderFont,
                NSForegroundColorAttributeName: CSJST_GlobalConstants.PlaceholderColor,
                NSParagraphStyleAttributeName: style
            ])
        // 上线账号
        //        textField.contentVerticalAlignment = .Center
        textField.text = ""
    }
    var textFieldText: String? {
        get {
            return textField.text
        }
    }
}

//按钮cell
class TextWithButtonCell: UITableViewCell, TextCell {
    
    let tickerUpperLimit = 60
    var tickTimes = 0
    var ticker: NSTimer?
    
    weak var parentView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var smsCodeString : String = ""
    
    
    func setupWithPlaceHolder(placeHolder: String) {
        let style : NSMutableParagraphStyle = textField.defaultTextAttributes[NSParagraphStyleAttributeName]!.mutableCopy() as! NSMutableParagraphStyle
        style.minimumLineHeight = textField.font!.lineHeight - (textField.font!.lineHeight - UIFont.systemFontOfSize(13.0).lineHeight) / 2.0
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes:
            [
                NSFontAttributeName: CSJST_GlobalConstants.PlaceholderFont,
                NSForegroundColorAttributeName: CSJST_GlobalConstants.PlaceholderColor,
                NSParagraphStyleAttributeName: style
                
            ])
        //上线账号 13611111111
        //        textField.text = "18601784252"
        textField.text = ""
        button.hidden = false
        button.addTarget(self, action: #selector(TextWithButtonCell.beginTicker(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextWithButtonCell.resetTicker), name: "viewDidDisappear", object: nil)
    }
    
    //输入密码字段的时候用
    func setupWithPlaceHolder2(placeHolder: String) {
        let style : NSMutableParagraphStyle = textField.defaultTextAttributes[NSParagraphStyleAttributeName]!.mutableCopy() as! NSMutableParagraphStyle
        style.minimumLineHeight = textField.font!.lineHeight - (textField.font!.lineHeight - UIFont.systemFontOfSize(13.0).lineHeight) / 2.0
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes:
            [
                NSFontAttributeName: CSJST_GlobalConstants.PlaceholderFont,
                NSForegroundColorAttributeName: CSJST_GlobalConstants.PlaceholderColor,
                NSParagraphStyleAttributeName: style
                
            ])
        //上线账号 13611111111
        //        textField.text = "18601784252"
        textField.text = ""
        button.hidden = true
        button.addTarget(self, action: #selector(TextWithButtonCell.beginTicker(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextWithButtonCell.resetTicker), name: "viewDidDisappear", object: nil)
    }
    
    var textFieldText: String? {
        get {
            return textField.text
        }
    }
    
    //MARK:获取验证码
    func beginTicker(sender: UIButton!) {
        guard ticker == nil && tickTimes == 0 else {return}
        
        parentView.endEditing(true)
        guard let text = textField.text where text.isValidPhoneNumber() else {
            MBProgressHUD.showWithStatus("请输入正确的手机号", onView: parentView)
            return
        }
        
        sender.enabled = false
        sender.setTitle("(\(tickerUpperLimit - tickTimes)S) 重新获取", forState: .Normal)
        ticker = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TextWithButtonCell.ticks), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(ticker!, forMode: NSRunLoopCommonModes)
        
        //随机数
        let temp:Int = Int(arc4random_uniform(9))+0
        //        var smsCode : Int = 10
        if (NSUserDefaults().integerForKey("beginTicker_Item") != 0){
            let smsOne_Save: Int = NSUserDefaults().integerForKey("beginTicker_Item")
            print("之前存着的 十位数 = \(smsOne_Save)")
            var smsOne_New : Int = 0
            if (smsOne_Save == 9){
                smsOne_New = 1
                NSUserDefaults().setInteger(smsOne_New, forKey: "beginTicker_Item")
                let smsOne_Shiwei = smsOne_New * 10
                let smsCode = smsOne_Shiwei + temp
                print("已有smsCode = \(smsCode)")
                self.smsCodeString = "\(smsCode)"
//                ContentManager.sharedInstance.securityCode(text, smsCode: self.smsCodeString, block: nil)
            }else{
                smsOne_New = smsOne_Save + 1
                NSUserDefaults().setInteger(smsOne_New, forKey: "beginTicker_Item")
                let smsOne_Shiwei = smsOne_New * 10
                let smsCode = smsOne_Shiwei + temp
                print("已有smsCode = \(smsCode)")
                self.smsCodeString = "\(smsCode)"
//                ContentManager.sharedInstance.securityCode(text, smsCode: self.smsCodeString, block: nil)
            }
        }else{
            //            var smsOne = NSUserDefaults().valueForKey("beginTicker_Item")
            let smsOne : Int = 1
            NSUserDefaults().setInteger(smsOne, forKey: "beginTicker_Item")
            let smsOne_Save : Int = NSUserDefaults().integerForKey("beginTicker_Item")
            print("smsOne_Save = \(smsOne_Save)")
            let smsOne_Shiwei = smsOne_Save * 10
            let smsCode = smsOne_Shiwei + temp
            print("smsCode = \(smsCode)")
            self.smsCodeString = "\(smsCode)"
//            ContentManager.sharedInstance.securityCode(text, smsCode: self.smsCodeString, block: nil)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("beginTicker_Item_NC", object: self.smsCodeString)
        
//        ContentManager.sharedInstance.securityCode(text, block: nil)
    }
    
    func resetTicker() {
        tickTimes = 0
        ticker?.invalidate()
        ticker = nil
        
        button.enabled = true
        //        button.setTitle("重新获取", forState: .Normal)
        button.setTitle("获取验证码", forState: .Normal)
    }
    
    func ticks() {
        tickTimes += 1
        let otherVariable = tickTimes
        if (otherVariable > tickerUpperLimit) {
            resetTicker()
            return
        }
        
        button.setTitle("(\(tickerUpperLimit - tickTimes)S) 重新获取", forState: .Normal)
    }
    
}

class TextPhoneCell : UITableViewCell {
    @IBOutlet weak var phoneLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
}

//MARK: 性别cell
class TextSexCell : UITableViewCell {
    
    @IBOutlet weak var sexLabel : UILabel!
    
    @IBOutlet weak var xiansheng_normal : UIImageView!
    @IBOutlet weak var xiansheng_click : UIImageView!
    @IBOutlet weak var xiansheng : UILabel!
    
    @IBOutlet weak var nvshi_normal : UIImageView!
    @IBOutlet weak var nvshi_click : UIImageView!
    @IBOutlet weak var nvshi : UILabel!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    func setupWithCell() {
        //先生
        let xiansheng_normalTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextSexCell.xiansheng_normalTap) )
        self.xiansheng_normal.userInteractionEnabled = true
        self.xiansheng_normal.addGestureRecognizer(xiansheng_normalTap)
        
        let xiansheng_clickTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextSexCell.xiansheng_clickTap) )
        self.xiansheng_click.userInteractionEnabled = true
        self.xiansheng_click.addGestureRecognizer(xiansheng_clickTap)
        
        let xianshengTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextSexCell.xianshengTap) )
        self.xiansheng.userInteractionEnabled = true
        self.xiansheng.addGestureRecognizer(xianshengTap)
        
        //女士
        let nvshi_normalTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextSexCell.nvshi_normalTap) )
        self.nvshi_normal.userInteractionEnabled = true
        self.nvshi_normal.addGestureRecognizer(nvshi_normalTap)
        
        let nvshi_clickTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextSexCell.nvshi_clickTap) )
        self.nvshi_click.userInteractionEnabled = true
        self.nvshi_click.addGestureRecognizer(nvshi_clickTap)
        
        let nvshiTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TextSexCell.nvshiTap) )
        self.nvshi.userInteractionEnabled = true
        self.nvshi.addGestureRecognizer(nvshiTap)
        
        //判断
        self.xiansheng_normal.hidden = false
        self.xiansheng_click.hidden = true
        
        self.nvshi_normal.hidden = false
        self.nvshi_click.hidden = true
        
        //状态初始化
        NSUserDefaults.standardUserDefaults().setObject("Nomal", forKey: "AJM_Panduan_BaomingSEX")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    //MARK: 男士
    func xiansheng_normalTap(){
        print("先生不点击-> 选中状态, 女士不选中")
        self.xiansheng_Method()
    }
    func xiansheng_clickTap(){
        print("先生选中状态-> 选中状态，女士不选中")
        self.xiansheng_Method()
    }
    func xianshengTap(){
        print("先生字体点击")
        self.xiansheng_Method()
    }
    func xiansheng_Method() {
        self.xiansheng_normal.hidden = true
        self.xiansheng_click.hidden = false
        
        self.nvshi_normal.hidden = false
        self.nvshi_click.hidden = true
        
        NSUserDefaults.standardUserDefaults().setObject("Mon", forKey: "AJM_Panduan_BaomingSEX")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //MARK: 女士
    func nvshi_normalTap(){
        print("女士正常点击->变选中状态， 先生未选中状态")
        self.nvshi_Method()
    }
    
    func nvshi_clickTap(){
        print("女士选中状态-> 选中状态，先生未选中")
        self.nvshi_Method()
    }
    func nvshiTap() {
        print("女士字体点击")
        self.nvshi_Method()
    }
    
    func nvshi_Method(){
        self.nvshi_normal.hidden = true
        self.nvshi_click.hidden = false
        
        self.xiansheng_normal.hidden = false
        self.xiansheng_click.hidden = true
        
        NSUserDefaults.standardUserDefaults().setObject("Womon", forKey: "AJM_Panduan_BaomingSEX")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
}
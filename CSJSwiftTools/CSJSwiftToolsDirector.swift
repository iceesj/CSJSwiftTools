//
//  CSJSwiftToolsDirector.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD

let SCREEN_WIDTH_CSJST = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT_CSJST = UIScreen.main.bounds.size.height

//单例导演类 提供各种方法
class CSJSwiftToolsDirector: NSObject {
    static let sharedInstance = CSJSwiftToolsDirector()
    
    /**
     等宽，不同高度计算
     */
    func changeHight(_ height :CGFloat) -> CGFloat? {
        let newHeight : CGFloat = SCREEN_WIDTH_CSJST * height / CGFloat(640)
        return CGFloat(newHeight) 
    }
    
    /*
     转换时段 时间截取 DoujiangViewController用
     */
    func zhuanhuanShiduanInt(_ value :String) -> (Int){
        //String字符串长度
        //        let strLength = value.characters.count
        let valueString : NSString = value as NSString
        print("valueString = \(valueString)")
        //csj修改-后字段
//        let subValue = valueString.rangeOfString("-").location+1
//        print("subVlue = \(subValue)")
        //csj修改-前字段
//        let loc = valueString.rangeOfString("-").location
//        let behind_subValue = valueString.substringWithRange(NSMakeRange(0, loc))
//        print("subValue2 = \(behind_subValue)")
//        let ss:NSString = valueString.substringWithRange(NSMakeRange(0, loc)) as NSString
        let ss:NSString = value as NSString
        print("ss = \(ss)")
        
        let ssLength = ss.length
        let ss1range = ss.range(of: ":").location
        let ss2range = ss.range(of: ":").location+1
        let ss1 : NSString = ss.substring(with: NSMakeRange(0, ss1range)) as NSString
        let ss2 : NSString = ss.substring(with: NSMakeRange(ss2range, ssLength-ss2range)) as NSString
        print("ss1 = \(ss1),ss2 = \(ss2)")
        let ssNew = "\(ss1)\(ss2)"
        //        print("ssNew = \(ssNew)")
        //        print("nowTimeHHmm = \(nowTimeHHmm)")
        let ssNewInt : Int = Int(ssNew)!
        return ssNewInt
    }
    
    /*
     JSON的String 转化成 dict
     */
    func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something String to AnyObject wrong")
            }
        }
        return nil
    }
    
    
    /*
     分割时间 符号 -
     */
    func fengeTime(_ resultString :String!) -> (string1 : String? ,string2 : String?){
        let strLength = resultString.characters.count
        let resultStringNew : NSString = resultString as NSString
        let subValue = resultStringNew.range(of: "-").location+1
        print("subVlue = \(subValue)")
        let subString1 = resultStringNew.substring(with: NSMakeRange(0, subValue-1)) as NSString
        let subString2 = resultStringNew.substring(with: NSMakeRange(subValue, strLength-subValue)) as NSString
        return (string1:subString1 as String,string2:subString2 as String)
    }
    
    /*
     fengeString 为需要分割的字符
     */
    func fengeStringCOMMON(_ resultString : String, _ fengeString : String) -> (string1 : String? ,string2 : String?){
        let strLength = resultString.characters.count
        let fengeStringLength = fengeString.characters.count
        let resultStringNew : NSString = resultString as NSString
        let subValue = resultStringNew.range(of: fengeString).location+fengeStringLength
        print("su bVlueInt = \(subValue)")
        let subString1 = resultStringNew.substring(with: NSMakeRange(0, subValue-1)) as NSString
        let subString2 = resultStringNew.substring(with: NSMakeRange(subValue, strLength-subValue)) as NSString
        return (string1:subString1 as String,string2:subString2 as String)
    }
    
    
    // if file doesn't exist or any error happens
    fileprivate class func dataForFileName(_ folder: String, name: String) -> Data? {
        let path = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) ).first!
        let manager = Foundation.FileManager.default
        
        //csjswift
        let filePath = ""
        guard filePath == URL(fileURLWithPath: path).appendingPathComponent(folder).appendingPathComponent(name).path else {return nil}
        
        
        if manager.fileExists(atPath: filePath) {
            return (try? Data(contentsOf: URL(fileURLWithPath: filePath)))
        }
        return nil
    }
    
    func saveDataOfFileName(_ data: Data, folder: String, name: String, override: Bool) -> Bool {
        let cachePath = (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)).first!
        let url = URL(fileURLWithPath: cachePath).appendingPathComponent(folder)
//        let manager = FileManager.default
        let manager = Foundation.FileManager.default
        
        let folderPath = url.path
        if folderPath == ""{
            return false
        }
        let filePath = url.appendingPathComponent(name).path
        if filePath == ""{
            return false
        }
//        guard let folderPath = url.path else {return false}
//        guard let filePath = url.appendingPathComponent(name).path else {return false}
        
        do {
            if !manager.fileExists(atPath: folderPath) {
                try manager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }
            if !manager.fileExists(atPath: filePath) || override {
                return ((try? data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])) != nil)
            }
            return true
        } catch let error {
            print("save file data error: \(error)")
            return false
        }
    }
    
    
    /**返回上一页*/
    func ui_backToLastVC(_ view: UIView) {
        let vc = view.findUIViewController()
        let _ = vc?.navigationController?.popViewController(animated: true)
    }
    
    /**
     展示一个只有确定的警告框
     */
    func ui_showAlert确定View(_ vc: UIViewController, title:String,message:String,block:((_ quedingString: String?) -> Void)?) {
//        let alert = UIAlertView()
//        alert.title = title
//        alert.message = message
//        alert.addButtonWithTitle("确定")
//        alert.show()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定",style: .default, handler: { action in
            print("你猜 确定")
            block?("确定")
        }))
        vc.present(alertController, animated: true, completion: nil)
    }
    
    /**自定义Alert*/
    func ui_showAlertVC(_ vc: UIViewController, title : String, message : String,block:((_ quedingString: String?) -> Void)? , block2:((_ quxiaoString: String?) -> Void)? ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定",style: .default, handler: { action in
            print("你猜 确定")
            block?("确定")
        }))
        alertController.addAction(UIAlertAction(title: "取消",style: .cancel, handler: { action in
            print("你猜 取消")
            block2?("取消")
        }))
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func ui_showActionSheet(_ vc: UIViewController, title: String, message: String, block:((_ quedingString: String?) -> Void)? , block2:((_ quxiaoString: String?) -> Void)? ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "确定",style: .default, handler: { action in
            print("你猜 确定")
            block?("确定")
        }))
        alertController.addAction(UIAlertAction(title: "取消",style: .cancel, handler: { action in
            print("你猜 取消")
            block2?("取消")
        }))
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
    //错误 删除
    class func shijianChuo_13Num() -> NSString {
        let dat : Date = Date.init(timeIntervalSinceNow: 0)
        print("dat = \(dat)")
        let a : TimeInterval = dat.timeIntervalSince1970 * 1000
        let timeString = NSString (format: "%.f", a)
        print("timeString = \(timeString)")
        return timeString
    }
    
    class func shijianChuo_10Num() -> NSString {
        let dat : Date = Date.init(timeIntervalSinceNow: 0)
        print("dat = \(dat)")
        let a : TimeInterval = dat.timeIntervalSince1970
        let timeString = NSString (format: "%.f", a)
        print("timeString = \(timeString)")
        return timeString
    }
    
    
    //替换 ？替换成 /
    func stringTihuan(_ fullString : String, _ firstString : String, _ secondString : String) -> String {
//        var filtered = fullString.stringByReplacingOccurrencesOfString("?", withString: "/", options: NSString.CompareOptions.LiteralSearch, range: nil)
        let filtere = fullString.replacingOccurrences(of: firstString, with: secondString, options: String.CompareOptions.literal, range: nil)
        return filtere
    }
    
    //过滤
    func stringGuolv(_ fullString : String, _ needReplace : String) -> String {
        let filtere = fullString.replacingOccurrences(of: needReplace, with: "", options: String.CompareOptions.literal, range: nil)
        return filtere
    }
    
    //切割
    func stringQiege(_ fullString: String,_ qiegeString: String) -> [String]{
        //swift 2
//        let fullNameArr = fullName.characters.split{$0 == " "}.map(String.init)
//        let fullNameArr = fullString.characters.split{" "}.map(String.init)
        //swift 3
        let fullNameArr : [String] = fullString.components(separatedBy: qiegeString)
        return fullNameArr
    }
    
    //拼接
    func arrayChangeString(_ array: [String]) -> String {
        let result = array.joined(separator: "/")
        return result
    }
    
    func Show(message:String = "Processing...",delegate:UIViewController){
        var load : MBProgressHUD = MBProgressHUD()
        load = MBProgressHUD.showAdded(to: delegate.view, animated: true)
        load.mode = MBProgressHUDMode.indeterminate
        if(message.characters.count > 0)
        {
            //            load.label.text = message
            load.labelText = message
        }
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func Hide(delegate:UIViewController){
        MBProgressHUD.hide(for: delegate.view, animated: true)
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func versionNumber() -> String {
        let versionNumber = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0"
        return versionNumber
    }
    
    
    class func timeStampToString(dateFormat:String ,timeStamp:String)->String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        //"HH:mm:ss"
        dfmatter.dateFormat=dateFormat
        let date = NSDate(timeIntervalSince1970: timeSta)
        //        print(dfmatter.string(from: date as Date))
        return dfmatter.string(from: date as Date)
    }
    
    class func isToday(date: Date) -> Bool {
        let nowTimeHHmm = (Date() as NSDate).string(withFormat: "yyyy-MM-dd")
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDate = dateFormatter.date(from: "\(nowTimeHHmm!)")!
        print("myDate = \(myDate)")
        
        if date == myDate{
            return true
        }else{
            return false
        }
    }
    
    class func csj_isNull(any: String?) -> Bool{
        guard any?.isEmpty == false else {
            return true
        }
        guard any != nil else {
            return true
        }
        guard any?.characters.count != 0 else {
            return true
        }
        return false
    }
    
    //分割每一个字符 中间加空格
    class func insert(seperator: String, afterEveryXChars: Int, intoString: String) -> String {
        var output = ""
        intoString.characters.enumerated().forEach { index, c in
            if index % afterEveryXChars == 0 && index > 0 {
                output += seperator
            }
            output.append(c)
        }
        return output
    }
    
    class func isNumber(string : String) -> Bool {
        for temp in string.characters{
            guard temp.isNumber == true else {
                return false
            }
        }
        return true
    }
    
}






//MARK: Swift全局共有类
struct CSJST_GlobalConstants {
    static let PromptLoginViewControllerStoryboardID = "Login Navigation Controller"
    static var blackColor = UIColor.black
    static var darkGrayColor = UIColor.darkGray
    static var lightGrayColor = UIColor.lightGray
    static var whiteColor = UIColor.white
    static var grayColor = UIColor.gray
    static var redColor = UIColor.red
    static var greenColor = UIColor.green
    static var blueColor = UIColor.blue
    static var cyanColor = UIColor.cyan
    static var yellowColor = UIColor.yellow
    static var magentaColor = UIColor.magenta
    static var orangeColor = UIColor.orange
    static var purpleColor = UIColor.purple
    static var brownColor = UIColor.brown
    static var clearColor = UIColor.clear
    
    
    
    static var BarTintColor            = UIColor(red: 250.0 / 255.0, green: 210.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    static var BannerBackgroundColor   = UIColor.white
    
    //appdelegate 统一颜色
    //    static var NavigationForegroundColor = UIColor(red: 120.0 / 255.0, green: 66.0 / 255.0, blue: 3.0 / 255.0, alpha: 1.0)
    static var NavigationForegroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    
    //    static var NavigationTitleColor = UIColor(red: 162.0 / 255.0, green: 90.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
    //第六次迭代-统一改成黑色
    static var NavigationTitleColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    static var NavigationTitleColor_White = UIColor.white
    
    static var Main_BackgroundColor = UIColor(red: 243.0 / 255.0, green: 245.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    //灰线
    static var Line_Color = UIColor(red: 226.0 / 255.0, green: 231.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    
    static var TabbarTextNormalColor   = UIColor(red: 106.0 / 255.0, green: 106.0 / 255.0, blue: 106.0 / 255.0, alpha: 1.0)
    static var TabbarTextSelectedColor = UIColor(red: 249.0 / 255.0, green: 205.0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    static var BarButtonItemColor      = UIColor(red: 120.0 / 255.0, green: 66.0 / 255.0, blue: 3.0 / 255.0, alpha: 1.0)
    
    static var CycleViewDotColor = UIColor(red: 250.0 / 255.0, green: 210.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    static var PlaceholderColor = UIColor(red: 153.0 / 255.0, green: 152.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    
    static let FinishedLineBackgroundColor = UIColor(red: 72.0 / 255.0, green: 207.0 / 255.0, blue: 173.0 / 255.0, alpha: 1.0)
    static let UnfinishedLineBackgroundColor = UIColor(red: 232.0 / 255.0, green: 236.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    
    //tableView分割线
    static let tableViewLineAJM = UIColor(red: 232/255.0, green: 236/255.0, blue: 242/255.0, alpha: 1.0)
    
    //    static let tableViewLineAJM = UIColor(red: 227/255.0, green: 91/255.0, blue: 21/255.0, alpha: 1.0)
    
    //西底颜色
    static let toolbarViewColor = UIColor(red: 37/255.0, green: 42/255.0, blue: 45/255.0, alpha: 0.95)
    
    //购物车底色
    static let toolbarViewPriceColor = UIColor(red: 217/255.0, green: 90/255.0, blue: 4/255.0, alpha: 0.8)
    
    //橘色
    static let tuangou_orange_color = UIColor(red: 227/255.0, green: 91/255.0, blue: 21/255.0, alpha: 1.0)
    
    //header Background
    static let adreess_Header_Background = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
    
    //黄色
    static let Normal_Yellow_AJM = UIColor(red: 250/255, green: 210/255, blue: 9/255, alpha: 1.0)
    
    //字体
    static var BarButtonItemFont = UIFont.systemFont(ofSize: 13.0)
    static var TabbarTextFont = UIFont.systemFont(ofSize: 11.0)
    static var NavigationBarFont = UIFont.systemFont(ofSize: 17.0)
    static var EmptyTitleFont = UIFont.systemFont(ofSize: 13.0)
    static var PlaceholderFont = UIFont.systemFont(ofSize: 13.0)
    static var HUDFont = UIFont.systemFont(ofSize: 15.0)
    static let NavigationTitleFont = UIFont.systemFont(ofSize: 17.0)
    
    //高度
    //frame 1
    static var height_banner = CGFloat(SCREEN_WIDTH_CSJST * 120 / 320)
}












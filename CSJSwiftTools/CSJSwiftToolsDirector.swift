//
//  CSJSwiftToolsDirector.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import Foundation

let SCREEN_WIDTH_CSJST = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT_CSJST = UIScreen.mainScreen().bounds.size.height

//单例导演类 提供各种方法
class CSJSwiftToolsDirector: NSObject {
    static let sharedInstance = CSJSwiftToolsDirector()
    
    /**
     等宽，不同高度计算
     */
    func changeHight(height :CGFloat) -> CGFloat? {
        let newHeight : CGFloat = SCREEN_WIDTH_CSJST * height / CGFloat(640)
        return CGFloat(newHeight) ?? 0
    }
    
    /*
     转换时段 时间截取 DoujiangViewController用
     */
    func zhuanhuanShiduanInt(value :String) -> (Int){
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
        let ss1range = ss.rangeOfString(":").location
        let ss2range = ss.rangeOfString(":").location+1
        let ss1 : NSString = ss.substringWithRange(NSMakeRange(0, ss1range))
        let ss2 : NSString = ss.substringWithRange(NSMakeRange(ss2range, ssLength-ss2range))
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
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
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
    func fengeTime(resultString :String!) -> (string1 : String! ,string2 : String!){
        let strLength = resultString.characters.count
        let resultStringNew : NSString = resultString as NSString
        let subValue = resultStringNew.rangeOfString("-").location+1
        print("subVlue = \(subValue)")
        let subString1 = resultStringNew.substringWithRange(NSMakeRange(0, subValue-1)) as NSString
        let subString2 = resultStringNew.substringWithRange(NSMakeRange(subValue, strLength-subValue)) as NSString
        return (string1:subString1 as String,string2:subString2 as String)
    }
    
    /*
     fengeString 为需要分割的字符
     */
    func fengeStringCOMMON(resultString : String, _ fengeString : String) -> (string1 : String! ,string2 : String!){
        let strLength = resultString.characters.count
        let fengeStringLength = fengeString.characters.count
        let resultStringNew : NSString = resultString as NSString
        let subValue = resultStringNew.rangeOfString(fengeString).location+fengeStringLength
        print("su bVlueInt = \(subValue)")
        let subString1 = resultStringNew.substringWithRange(NSMakeRange(0, subValue)) as NSString
        let subString2 = resultStringNew.substringWithRange(NSMakeRange(subValue, strLength-subValue)) as NSString
        return (string1:subString1 as String,string2:subString2 as String)
    }
    
    
    // if file doesn't exist or any error happens
    private class func dataForFileName(folder: String, name: String) -> NSData? {
        let path = (NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) ).first!
        let manager = NSFileManager.defaultManager()
        guard let filePath = NSURL(fileURLWithPath: path)
            .URLByAppendingPathComponent(folder)
            .URLByAppendingPathComponent(name).path else {return nil}
        
        if manager.fileExistsAtPath(filePath) {
            return NSData(contentsOfFile: filePath)
        }
        return nil
    }
    
    func saveDataOfFileName(data: NSData, folder: String, name: String, override: Bool) -> Bool {
        let cachePath = (NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)).first!
        let url = NSURL(fileURLWithPath: cachePath).URLByAppendingPathComponent(folder)
        let manager = NSFileManager.defaultManager()
        guard let folderPath = url.path else {return false}
        guard let filePath = url.URLByAppendingPathComponent(name).path else {return false}
        
        do {
            if !manager.fileExistsAtPath(folderPath) {
                try manager.createDirectoryAtPath(folderPath, withIntermediateDirectories: true, attributes: nil)
            }
            if !manager.fileExistsAtPath(filePath) || override {
                return data.writeToFile(filePath, atomically: true)
            }
            return true
        } catch let error {
            print("save file data error: \(error)")
            return false
        }
    }
    
    
    /**返回上一页*/
    func ui_backToLastVC(view: UIView) {
        let vc = view.findUIViewController()
        vc?.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     展示一个只有确定的警告框
     */
    func ui_showAlert确定View(vc: UIViewController, title:String,message:String,block:((quedingString: String?) -> Void)?) {
//        let alert = UIAlertView()
//        alert.title = title
//        alert.message = message
//        alert.addButtonWithTitle("确定")
//        alert.show()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "确定",style: .Default, handler: { action in
            print("你猜 确定")
            block?(quedingString: "确定")
        }))
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /**自定义Alert*/
    func ui_showAlertVC(vc: UIViewController, title : String, message : String,block:((quedingString: String?) -> Void)? , block2:((quxiaoString: String?) -> Void)? ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "确定",style: .Default, handler: { action in
            print("你猜 确定")
            block?(quedingString: "确定")
        }))
        alertController.addAction(UIAlertAction(title: "取消",style: .Cancel, handler: { action in
            print("你猜 取消")
            block2?(quxiaoString: "取消")
        }))
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func ui_showActionSheet(vc: UIViewController, title: String, message: String, block:((quedingString: String?) -> Void)? , block2:((quxiaoString: String?) -> Void)? ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: "确定",style: .Default, handler: { action in
            print("你猜 确定")
            block?(quedingString: "确定")
        }))
        alertController.addAction(UIAlertAction(title: "取消",style: .Cancel, handler: { action in
            print("你猜 取消")
            block2?(quxiaoString: "取消")
        }))
        vc.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    class func shijianChuo_13Num() -> NSString {
        let dat : NSDate = NSDate.init(timeIntervalSinceNow: 0)
        print("dat = \(dat)")
        let a : NSTimeInterval = dat.timeIntervalSince1970 * 1000
        let timeString = NSString (format: "%.f", a)
        print("timeString = \(timeString)")
        return timeString
    }
    
    class func shijianChuo_10Num() -> NSString {
        let dat : NSDate = NSDate.init(timeIntervalSinceNow: 0)
        print("dat = \(dat)")
        let a : NSTimeInterval = dat.timeIntervalSince1970
        let timeString = NSString (format: "%.f", a)
        print("timeString = \(timeString)")
        return timeString
    }
    
}

//MARK: Swift全局共有类
struct CSJST_GlobalConstants {
    static let PromptLoginViewControllerStoryboardID = "Login Navigation Controller"
    static var blackColor = UIColor.blackColor()
    static var darkGrayColor = UIColor.darkGrayColor()
    static var lightGrayColor = UIColor.lightGrayColor()
    static var whiteColor = UIColor.whiteColor()
    static var grayColor = UIColor.grayColor()
    static var redColor = UIColor.redColor()
    static var greenColor = UIColor.greenColor()
    static var blueColor = UIColor.blueColor()
    static var cyanColor = UIColor.cyanColor()
    static var yellowColor = UIColor.yellowColor()
    static var magentaColor = UIColor.magentaColor()
    static var orangeColor = UIColor.orangeColor()
    static var purpleColor = UIColor.purpleColor()
    static var brownColor = UIColor.brownColor()
    static var clearColor = UIColor.clearColor()
    
    
    
    static var BarTintColor            = UIColor(red: 250.0 / 255.0, green: 210.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    static var BannerBackgroundColor   = UIColor.whiteColor()
    
    //appdelegate 统一颜色
    //    static var NavigationForegroundColor = UIColor(red: 120.0 / 255.0, green: 66.0 / 255.0, blue: 3.0 / 255.0, alpha: 1.0)
    static var NavigationForegroundColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    
    //    static var NavigationTitleColor = UIColor(red: 162.0 / 255.0, green: 90.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
    //第六次迭代-统一改成黑色
    static var NavigationTitleColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    static var NavigationTitleColor_White = UIColor.whiteColor()
    
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
    static var BarButtonItemFont = UIFont.systemFontOfSize(13.0)
    static var TabbarTextFont = UIFont.systemFontOfSize(11.0)
    static var NavigationBarFont = UIFont.systemFontOfSize(17.0)
    static var EmptyTitleFont = UIFont.systemFontOfSize(13.0)
    static var PlaceholderFont = UIFont.systemFontOfSize(13.0)
    static var HUDFont = UIFont.systemFontOfSize(15.0)
    static let NavigationTitleFont = UIFont.systemFontOfSize(17.0)
    
    //高度
    //frame 1
    static var height_banner = CGFloat(SCREEN_WIDTH_CSJST * 120 / 320)
}












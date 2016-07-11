//
//  CSJST+UILabel.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension UILabel
{
    /**
     设置多个颜色的文本
     */
    public func setMultipleColorText(texts: Array<(color:UIColor,text:String)> ){
        
        var string = ""
        for text in texts{
            string =  string.stringByAppendingString(text.text)
        }
        let aString = NSMutableAttributedString(string: string)
        
        var location = 0
        for text in texts{
            let length = (text.text as NSString).length
            aString.addAttribute(NSForegroundColorAttributeName, value: text.color, range: NSMakeRange(location,length))
            location += length
        }
        self.attributedText = aString
    }
}
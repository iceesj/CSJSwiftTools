//
//  CSJST+UIWebView.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension UIWebView
{
    
    func injectJS_csjst(name: String?, ofType ext: String?) -> String?
    {
        let path = NSBundle.mainBundle().pathForResource(name, ofType:ext)
        let js   = try? NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        
        let find = NSString(format:"var script = document.createElement('script');script.type = 'text/javascript';script.text = %@;document.getElementsByTagName('body')[0].appendChild(script);",js!) as String
        
        //注入js
        return self.stringByEvaluatingJavaScriptFromString(find)
    }
    
    
    func js_csjst(theJS:String!) -> String?
    {
        return self.stringByEvaluatingJavaScriptFromString(theJS)
    }
    
    
    func loadURL_csjst(url:NSURL?)
    {
        if url != nil
        {
            let request = NSURLRequest(URL: url!)
            self.loadRequest(request)
        }
    }
    func loadURLString_csjst(s:String)
    {
        if let URL = NSURL(string: s)
        {
            let request = NSURLRequest(URL: URL)
            self.loadRequest(request)
        }
    }
    func loadFile_csjst(name: String?, ofType ext: String?)
    {
        let path = NSBundle.mainBundle().pathForResource(name, ofType:ext)
        let content   = (try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)) as String
        
        self.loadHTMLString(content, baseURL: NSURL(string: "")!)
    }
    func webTitle_csjst() -> String
    {
        let value = self.stringByEvaluatingJavaScriptFromString("document.title")
        return value ?? ""
    }
    func webDescription_csjst() -> String
    {
        let value = self.stringByEvaluatingJavaScriptFromString("document.getElementById(\"description\").content")
        return value ?? ""
    }
    
    
}
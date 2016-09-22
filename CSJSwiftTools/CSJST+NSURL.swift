//
//  CSJST+NSURL.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension URL
{
    /*
    public subscript(key:String) -> String{
        get{
            return parameters()[key] ?? ""
        }
    }
    */
    
    /*
    public func parameters()-> Dictionary<String,String>{
        var params = [String:String]()
        let query = self.query ?? ""
        for paramString in query.components(separatedBy: "&"){
            let paramPair = paramString.components(separatedBy: "=")
            if paramPair.count == 2{
                let key     = paramPair[0].stringByRemovingPercentEncoding ?? ""
                let value   = paramPair[1].stringByRemovingPercentEncoding ?? ""
                params[key] = value
            }
        }
        return params
    }
    */
}
    

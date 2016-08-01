//
//  DDNViewModel.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/27.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveViewModel

class DDNViewModel: RVMViewModel {
    dynamic var userInfo1 : NSDictionary?
    
    
    convenience init(_ dictionary: Dictionary<String, AnyObject>) {
        self.init()
        userInfo1 = dictionary
        self.setup()
    }
    
    
    func setup(){
        
    }
}

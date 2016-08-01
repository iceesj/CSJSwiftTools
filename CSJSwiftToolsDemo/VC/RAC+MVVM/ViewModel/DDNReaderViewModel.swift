//
//  DDNReaderViewModel.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/27.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveViewModel
import ReactiveCocoa.RACSubscriptingAssignmentTrampoline

class DDNReaderViewModel: DDNViewModel {
    var error: NSError?
    /*
    var list : NSMutableArray{
        get{
            return NSMutableArray(capacity: 0)
        }
    }
    */
    var list : NSMutableArray?
    
    var loadNewCommand: RACCommand!
    var loadMoreCommand: RACCommand!
    
    var errors : RACSubject!
    
    
    override func setup(){
        self.setupRACCommand()
    }
    
    func setupRACCommand() {
        self.loadNewCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                let list : NSArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                print("list = \(list)")
                self.list = NSMutableArray(array: list)
                subscriber.sendNext(self.list)
                subscriber.sendCompleted()
                
                return nil
            })
        })
        
        self.loadMoreCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                let list : NSArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                print("list = \(list)")
                self.list = NSMutableArray(array: list)
                subscriber.sendNext(self.list)
                subscriber.sendCompleted()
                
                return nil
            })
        })
        RACSignal.merge([self.loadNewCommand.errors,self.loadMoreCommand.errors]).subscribe(self.errors)
//        RAC(self, error) = self.errors.subscribeOn(RACScheduler.mainThreadScheduler).distinctUntilChanged
    }
    
}







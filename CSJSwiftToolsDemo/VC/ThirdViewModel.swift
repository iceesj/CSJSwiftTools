//
//  ThirdViewModel.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/26.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxViewModel

class ThirdViewModel: RxViewModel {
//class ThirdViewModel: NSObject {
    dynamic var dataIndex : String = ""
//    dynamic var dataSource : NSMutableArray!
    dynamic var dataSource = [TestUserModel]()
//    dynamic var users1 = [TestUser]()
    
    /*
    override init() {
        super.init()
        self.setupData()
    }
    */
    
    func getUsers() -> Observable<[SectionModel<String, TestUserModel>]> {
        return Observable.create({ (observer) -> Disposable in
            ///*
//            self.dataSource = NSMutableArray.init(capacity: 0)
            for i in 0..<10 {
                let model = TestUserModel()
                model.screenName = NSString.localizedStringWithFormat("%d", i) as String
//                self.dataSource.addObject(model)
                self.dataSource.append(model)
            }
            print("dataSource = \(self.dataSource)")
            //*/
            
            let users = [TestUser(followersCount: 19_901_990, followingCount:1990, screenName: "Marco Sun"),TestUser(followersCount: 19_901_990, followingCount:1990, screenName: "Marco Sun2")]
            print("users = \(users)")
            
            let section = [SectionModel(model: "", items: self.dataSource)]
//            let section = [SectionModel(model: "",items: users)]
            observer.onNext(section)
            observer.onCompleted()
            
            /*
//            let timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ThirdViewModel.timeUpdate), userInfo: nil, repeats: true)
//            timer.fire()
            
            //5秒更新
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (__int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
//                self.updateData()
//                let users = [TestUser(followersCount: 19_901_990, followingCount:1990, screenName: "Marco Sun")]
//                self.dataSource.removeAll()
                for i in 0..<10 {
                    let model = TestUserModel()
                    model.screenName = NSString.localizedStringWithFormat("%d", i) as String
                    //                self.dataSource.addObject(model)
                    self.dataSource.append(model)
                }
                
                let section = [SectionModel(model: "",items: self.dataSource)]
                observer.onNext(section)
//                observer.onCompleted()
            })
            */
            
            return AnonymousDisposable{}
        })
    }
    
    func timeUpdate() {
        print("")
    }
    
    func setupData() {
        print("setupData")
    }
    
    func updateData() {
        print("updateData")
    }
}

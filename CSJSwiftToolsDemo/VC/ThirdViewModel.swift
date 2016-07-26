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


class ThirdViewModel: NSObject {
    
    func getUsers() -> Observable<[SectionModel<String, TestUser>]> {
        return Observable.create({ (observer) -> Disposable in
            
            let users = [TestUser(followersCount: 19_901_990, followingCount:1990, screenName: "Marco Sun")]
            
            let section = [SectionModel(model: "",items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return AnonymousDisposable{}
        })
    }
}

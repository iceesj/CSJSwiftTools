//
//  RealmDetailBasicVC.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/23.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
//import RealmSwift


class RealmDetailBasicVC: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initCSJSTSetVC(UIColor.white, bool: true, title: "Realm Basic")
        
        /*
        let myDog = Dog()
        myDog.name = "大黄"
        myDog.age = 1
        print(" 狗狗的名字： \(myDog.name)")
        
        // 获取默认的 Realm 数据库
        let realm = try! Realm()
        
        // 检索 Realm 数据库，找到小于 2 岁 的所有狗狗
        let puppies = realm.objects(Dog.self).filter("age < 2")
        puppies.count // => 0 因为目前还没有任何狗狗被添加到了 Realm 数据库中
        print("puppies1 = \(puppies.count)")
        
        // 数据持久化操作十分简单
        try! realm.write {
            realm.add(myDog)
        }
        
        print("puppies2 = \(puppies.count)")
        
        DispatchQueue(label: "background", attributes: []).async {
            let realm = try! Realm()
            let theDog = realm.objects(Dog).filter("age == 1").first
            try! realm.write({
                theDog!.age = 3
            })
        }
        */
        
    }
    

}

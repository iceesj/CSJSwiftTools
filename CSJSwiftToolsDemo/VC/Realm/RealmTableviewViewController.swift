//
//  RealmTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/22.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object {
    dynamic var name = ""
    dynamic var picture: NSData? = nil // 支持可选值
    let dogs = List<Dog>()
}

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
    dynamic var owner : Person?
}


class RealmTableviewViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Realm Demo"
        
        self.mutableArray = ["Realm Basic","Realm TableView"]
        
        //init TableView
        self.tableView=UITableView(frame:CGRectMake(0, 0, SCREEN_WIDTH_CSJST, SCREEN_HEIGHT_CSJST-60),style:.Plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    
    
}


extension RealmTableviewViewController : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mutableArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = self.mutableArray[indexPath.row] as? String
        return cell
    }
}

extension RealmTableviewViewController : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("点击行数 = \(indexPath.row)")
        
        let string_click = self.mutableArray[indexPath.row] as! String
        print("点击的String = \(string_click)")
        
        if string_click == "Realm TableView" {
            print("Realm TableView")
            let vc : RealmDetailTableviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RealmDetailTableviewViewController") as! RealmDetailTableviewViewController
            //        vc.panduanString = "\(self.mutableArray[indexPath.row])"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if string_click == "Realm Basic"{
            print("Realm Basic")
            let vc : RealmDetailBasicVC = self.storyboard?.instantiateViewControllerWithIdentifier("RealmDetailBasicVC") as! RealmDetailBasicVC
            //        vc.panduanString = "\(self.mutableArray[indexPath.row])"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}







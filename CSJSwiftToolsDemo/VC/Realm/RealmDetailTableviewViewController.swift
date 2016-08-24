//
//  RealmDetailTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/22.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import RealmSwift

class DemoObject: Object {
    dynamic var title = ""
    dynamic var date = NSDate()
}

class DemoObject2 : Object {
    dynamic var title1 = ""
    dynamic var date = NSDate()
}



/*************************************************************************************/

class Cell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
}

class RealmDetailTableviewViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!
    
    let realm = try! Realm()
    let results = try! Realm().objects(DemoObject.self).sorted("date")
    
    //一个不透明的令牌从方法返回订阅更改一个Realm
    var notificationToken: NotificationToken?
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCSJSTSetVC(.whiteColor(), bool: true, title: "Realm Tableview")
        
        setupUI()
        
        //init TableView
        self.tableView=UITableView(frame:CGRectMake(0, 0, SCREEN_WIDTH_CSJST, SCREEN_HEIGHT_CSJST-60),style:.Plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clearColor()
//        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        //设置结果通知
        //领域集合变化 RealmCollectionChange
        self.notificationToken = results.addNotificationBlock({ (changes : RealmCollectionChange) in
            switch changes {
            case .Initial:
                /// /结果现在填充,可以访问不会阻塞用户界面
                self.tableView.reloadData()
                break
                //删除 增加 修改
            case .Update(_ , let deletions, let insertions, let modifications):
                //查询结果已经改变了,所以将它们应用到视图
                self.tableView.beginUpdates()
                self.tableView.insertRowsAtIndexPaths(insertions.map{ NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .Automatic)
                self.tableView.deleteRowsAtIndexPaths(deletions.map{ NSIndexPath(forRow: $0, inSection: 0) }, withRowAnimation: .Automatic)
                self.tableView.reloadRowsAtIndexPaths(modifications.map{ NSIndexPath(forRow: $0, inSection: 0) } , withRowAnimation: .Automatic)
                
                self.tableView.endUpdates()
                
                break
            case .Error(let err):
                fatalError("err = \(err)")
                break
            }
        })
        
    }

    //UI
    func setupUI() {
//        tableView.registerClass(Cell.self, forCellReuseIdentifier: "cell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BG Add",style: .Plain, target: self, action: #selector(backgroundAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(add))
        
    }
    
    func backgroundAdd(){
        print("backgroundAdd")
        
    }
    
    func add() {
        print("add")
        realm.beginWrite()
        realm.create(DemoObject.self, value:[RealmDetailTableviewViewController.randomString(), RealmDetailTableviewViewController.randomDate()])
        try! realm.commitWrite()
    }
    
    class func randomString() -> String {
        return "Title \(arc4random())"
    }
    
    class func randomDate() -> NSDate {
//        return NSDate.init()
        return NSDate(timeIntervalSince1970: NSTimeInterval(arc4random()))
    }
    
}

extension RealmDetailTableviewViewController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Realm Cell")
//        cell.textLabel?.text = self.mutableArray[indexPath.row] as? String
//        return cell
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! Cell
        let object = results[indexPath.row]
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.date.description
        return cell
    }
}

extension RealmDetailTableviewViewController : UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 90
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("点击行数 = \(indexPath.row)")
        
        /*
        let vc : POPDetailTableviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("POPDetailTableviewViewController") as! POPDetailTableviewViewController
        vc.panduanString = "\(self.mutableArray[indexPath.row])"
        self.navigationController?.pushViewController(vc, animated: true)
         */
    }
}









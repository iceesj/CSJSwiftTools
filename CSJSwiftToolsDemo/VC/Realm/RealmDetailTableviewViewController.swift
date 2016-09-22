//
//  RealmDetailTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/22.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
//import RealmSwift
//import Realm

/*
class DemoObject: Object {
    dynamic var title = ""
    dynamic var date = Date()
}

class DemoObject2 : Object {
    dynamic var title1 = ""
    dynamic var date = Date()
}
*/


/*************************************************************************************/

class Cell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
}

class RealmDetailTableviewViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!
    
    /*
    let realm = try! Realm()
    let results = try! Realm().objects(DemoObject.self).sorted(byProperty: "date")
    
    //一个不透明的令牌从方法返回订阅更改一个Realm
    var notificationToken: NotificationToken?
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCSJSTSetVC(UIColor.white, bool: true, title: "Realm Tableview")
        
        /*
        setupUI()
        
        //init TableView
        self.tableView=UITableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH_CSJST, height: SCREEN_HEIGHT_CSJST-60-50),style:.plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clear
//        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //设置结果通知
        //领域集合变化 RealmCollectionChange
        self.notificationToken = results.addNotificationBlock({ (changes : RealmCollectionChange) in
            switch changes {
            case .initial:
                /// /结果现在填充,可以访问不会阻塞用户界面
                self.tableView.reloadData()
                break
                //删除 增加 修改
            case .update(_ , let deletions, let insertions, let modifications):
                //查询结果已经改变了,所以将它们应用到视图
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) } , with: .automatic)
                
                self.tableView.endUpdates()
                
                break
            case .error(let err):
                fatalError("err = \(err)")
                break
            }
        })
        */
    }

    //UI
    func setupUI() {
//        tableView.registerClass(Cell.self, forCellReuseIdentifier: "cell")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "BG Add",style: .plain, target: self, action: #selector(backgroundAdd))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
    }
    
    func backgroundAdd(){
        print("backgroundAdd")
        
/*
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async { 
            let realm = try! Realm()
            realm.beginWrite()
            
            for _ in 0..<5 {
                realm.create(DemoObject.self , value: [RealmDetailTableviewViewController.randomString(), RealmDetailTableviewViewController.randomDate()] )
            }
            
            try! realm.commitWrite()
        }
*/
    }
    
    func add() {
/*
        print("add")
        realm.beginWrite()
        realm.create(DemoObject.self, value:[RealmDetailTableviewViewController.randomString(), RealmDetailTableviewViewController.randomDate()] )
        try! realm.commitWrite()
*/
    }
    
    class func randomString() -> String {
        return "Title \(arc4random())"
    }
    
    class func randomDate() -> Date {
//        return NSDate.init()
        return Date(timeIntervalSince1970: TimeInterval(arc4random()))
    }
    
}

/*
extension RealmDetailTableviewViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Realm Cell")
//        cell.textLabel?.text = self.mutableArray[indexPath.row] as? String
//        return cell
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! Cell
        let object = results[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.date.description
        return cell
    }
}

extension RealmDetailTableviewViewController : UITableViewDelegate {
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realm.beginWrite()
            realm.delete(results[(indexPath as NSIndexPath).row])
            try! realm.commitWrite()
        }
    }
    
    
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 90
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("点击行数 = \((indexPath as NSIndexPath).row)")
        
        /*
        let vc : POPDetailTableviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("POPDetailTableviewViewController") as! POPDetailTableviewViewController
        vc.panduanString = "\(self.mutableArray[indexPath.row])"
        self.navigationController?.pushViewController(vc, animated: true)
         */
    }
}

*/








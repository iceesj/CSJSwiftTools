//
//  RealmTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/22.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit


/*
class Person: Object {
    dynamic var name = ""
    dynamic var picture: Data? = nil // 支持可选值
    let dogs = List<Dog>()
}

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
    dynamic var owner : Person?
}
*/

class RealmTableviewViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Realm Demo"
        
        self.mutableArray = ["Realm Basic","Realm TableView"]

        
        /*
        //init TableView
        self.tableView=UITableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH_CSJST, height: SCREEN_HEIGHT_CSJST-60),style:.plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        */
    }

    
    
}


extension RealmTableviewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mutableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = self.mutableArray[(indexPath as NSIndexPath).row] as? String
        return cell
    }
}

extension RealmTableviewViewController : UITableViewDelegate {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("点击行数 = \((indexPath as NSIndexPath).row)")
        
        let string_click = self.mutableArray[(indexPath as NSIndexPath).row] as! String
        print("点击的String = \(string_click)")
        
        if string_click == "Realm TableView" {
            print("Realm TableView")
            let vc : RealmDetailTableviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "RealmDetailTableviewViewController") as! RealmDetailTableviewViewController
            //        vc.panduanString = "\(self.mutableArray[indexPath.row])"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if string_click == "Realm Basic"{
            print("Realm Basic")
            let vc : RealmDetailBasicVC = self.storyboard?.instantiateViewController(withIdentifier: "RealmDetailBasicVC") as! RealmDetailBasicVC
            //        vc.panduanString = "\(self.mutableArray[indexPath.row])"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}







//
//  CSJSnapKitDemoViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/3.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

class CSJSnapKitDemoViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "CSJSnapKitDemo"
        
        self.mutableArray = ["1","2","3","4","5"]
        
        //init TableView
        self.tableView=UITableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH_CSJST, height: SCREEN_HEIGHT_CSJST-60),style:.plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }
    
    
    
    
}


extension CSJSnapKitDemoViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mutableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = self.mutableArray[(indexPath as NSIndexPath).row] as? String
        return cell
    }
}


extension CSJSnapKitDemoViewController : UITableViewDelegate {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
//    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("点击行数 = \((indexPath as NSIndexPath).row)")
        
        let vc : CSJSnapKitDemoSecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CSJSnapKitDemoSecondViewController") as! CSJSnapKitDemoSecondViewController
        vc.panduanString = "\((indexPath as NSIndexPath).row+1)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}





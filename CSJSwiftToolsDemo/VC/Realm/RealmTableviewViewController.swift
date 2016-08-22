//
//  RealmTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/22.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTableviewViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "POPAnimation Demo"
        
        self.mutableArray = ["kPOPLayerSize","kPOPLayerPosition","kPOPViewFrame","kPOPViewAlpha","kPOPBOX"]
        
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
        
        /*
        let vc : POPDetailTableviewViewController = self.storyboard?.instantiateViewControllerWithIdentifier("POPDetailTableviewViewController") as! POPDetailTableviewViewController
        vc.panduanString = "\(self.mutableArray[indexPath.row])"
        self.navigationController?.pushViewController(vc, animated: true)
        */
    }
}







//
//  POPTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/18.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit


class POPTableviewViewController: UIViewController {
    
    var tableView : UITableView!
    var mutableArray : NSMutableArray!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "POPAnimation Demo"
        
        self.mutableArray = ["kPOPLayerSize","kPOPLayerPosition","kPOPViewFrame","kPOPViewAlpha","kPOPBOX"]
        
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


extension POPTableviewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mutableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MyTestCell")
        cell.textLabel?.text = self.mutableArray[(indexPath as NSIndexPath).row] as? String
        return cell
    }
}


extension POPTableviewViewController : UITableViewDelegate {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("点击行数 = \((indexPath as NSIndexPath).row)")
        
        let vc : POPDetailTableviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "POPDetailTableviewViewController") as! POPDetailTableviewViewController
        vc.panduanString = "\(self.mutableArray[(indexPath as NSIndexPath).row])"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}






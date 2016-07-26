//
//  ThirdViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/18.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ThirdViewController: UIViewController {
    
    let tableView: UITableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
    let reuseIdentifier = "\(TableViewCell.self)"
    //RxDataSources类指定了我们的数据源包括哪些内容，SectionModel带有一个String作为section的名字，User类作为item的类型
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel <String, TestUser>>()
    let viewModel = ThirdViewModel()
    let disposeBag = DisposeBag()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCSJSTSetVC(.whiteColor(), bool: true, title: "RxSwift界面")
        view.addSubview(tableView)
        
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        dataSource.configureCell = {
            _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! TableViewCell
            cell.tag = indexPath.row
            cell.user = user
            return cell
        }
        
        viewModel.getUsers().bindTo(tableView.rx_itemsWithDataSource(dataSource)).addDisposableTo(disposeBag)        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

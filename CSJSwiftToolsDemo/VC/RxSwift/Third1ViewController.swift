//
//  Third1ViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/27.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
//import RxSwift
//import RxCocoa
import SnapKit
//import RxDataSources


class Table1ViewCell: UITableViewCell {
    
    /*
    var user : TestUserModel? {
        willSet{
            let string = "screenName=\(newValue!.screenName),followersCount=\(newValue!.followersCount),followingCount=\(newValue!.followingCount)"
            backgroundColor = tag % 2 == 0 ? .lightGrayColor() : .whiteColor()
            textLabel?.text = string
            textLabel?.numberOfLines = 0
        }
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func example() {
        
    }
    
}

//总
class Third1ViewController: UIViewController, UITableViewDelegate {
    
    /*
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    let reuseIdentifier = "\(Table1ViewCell.self)"
//    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
    let dataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, String>>()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "汇总"
        
//        tableView.rx_setDelegate(self).addDisposableTo(disposeBag)
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
        view.addSubview(self.tableView)
        tableView.register(Table1ViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.snp.makeConstraints { (make) in
            //            make.left.top.equalTo(0)
            //            make.right.bottom.equalTo(0)
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        let items = Observable.just([
            AnimatableSectionModel(model: "123", items: [
                "RxDataSources",
                "Test2"
                ])
        ])
        
        dataSource.configureCell = { (_, tv, indexPath, element) in
//            let cell = tv.dequeueReusableCellWithIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! Table1ViewCell
            let cell = tv.dequeueReusableCell(withIdentifier: self.reuseIdentifier)!
            cell.textLabel?.text = "\(element)"
            return cell
        }
        
        items.bindTo(tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
        
//        tableView
//            .rx.itemSelected
//            .map { indexPath in
//                return (indexPath, self.dataSource.itemAtIndexPath(indexPath))
//            }
//            .subscribeNext { indexPath, model in
//                print("Tapped `\(model)` @ \((indexPath as NSIndexPath).row)")
//                if (indexPath as NSIndexPath).row == 0 {
//                    let vc2 = UIStoryboard.CSJST_initViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
//                    self.navigationController?.pushViewController(vc2, animated: true)
//                }
//            }
//            .addDisposableTo(disposeBag)
//
//        items
//            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(element) @ row \(row)"
//            }
//            .addDisposableTo(disposeBag)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
        label.text = self.dataSource.sectionAtIndex(section).model 
        return label
    }
    */

}

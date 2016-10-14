//
//  TableViewCell.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/26.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
//import RxCocoa
//import RxSwift

class TableViewCell: UITableViewCell {
    
    var user : TestUserModel? {
        willSet{
            let string = "screenName=\(newValue!.screenName),followersCount=\(newValue!.followersCount),followingCount=\(newValue!.followingCount)"
            backgroundColor = tag % 2 == 0 ? UIColor.lightGray : UIColor.white
            textLabel?.text = string
            textLabel?.numberOfLines = 0
        }
    }
    
    /*
    var user : TestUser? {
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

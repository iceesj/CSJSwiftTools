//
//  DDNNewsCell.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/28.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import Foundation


class DDNNewsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var phoneLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    func setup() {
//        self.setSeparatorInset = UIEdgeInsetsZero
//        self.setPreservesSuperviewLayoutMargins = false
//        self.setLayoutMargins = UIEdgeInsetsZero
        
        self.addSubViews()
    }
    
    func addSubViews() {
        
    }
    
}

//
//  FourthViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/26.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
//import DDNReaderTableViewCell

class DDNReaderTableViewCell : UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


class FourthViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /*
        let emptySequence = Observable<Int>.empty()
        _ = emptySequence.subscribe { event in
            print("event = \(event)")
        }
        */
    }
    
    /*
    internal func example(description: String, action:() -> ()) {
        print("\n--- \(description) example ---")
        action()
    }
    

    let disposeBag = DisposeBag()
    /**顺序写入控制台*/
    func writeSequenceToConsole<O: ObservableType>(name: String, squence: O) {
        squence.subscribe { e in
            print("Subscription: \(name), event: \(e)")
            }.addDisposableTo(disposeBag)
    }
    */
    
}

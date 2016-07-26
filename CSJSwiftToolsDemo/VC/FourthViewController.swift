//
//  FourthViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/26.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FourthViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let emptySequence = Observable<Int>.empty()
        _ = emptySequence.subscribe { event in
            print("event = \(event)")
        }
        
        
    }
    
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
    
    
}

//
//  SecondViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/14.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import FDStackView

//UIStackView demo
class SecondViewController: UITableViewController {
    
    @IBOutlet weak var stackView: FDStackView!
    @IBOutlet weak var forkingdogImageView: UIImageView!
    @IBOutlet weak var axisSegmentControl: UISegmentedControl!
    @IBOutlet weak var alignmentSegmentControl: UISegmentedControl!
    @IBOutlet weak var distributionSegmentControl: UISegmentedControl!
    @IBOutlet weak var spacingSlider: UISlider!
    @IBOutlet weak var spacingLabel: UILabel!
    var mutableAddingViews: NSMutableArray!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCSJSTSetVC(UIColor.white ,bool: true, title: "界面二 StackView")
        
        
        print("进入StackView")
        
        self.updateFromStackViewAttributes()
    }

    func updateFromStackViewAttributes(){
//        self.stackView.axis = .Vertical
//        self.stackView.alignment = .Center
//        self.stackView.distribution = .Fill
//        print("self.tableView.tableHeaderView = \(self.tableView.tableHeaderView)")
        
        self.axisSegmentControl.selectedSegmentIndex = self.stackView.axis.rawValue
        print("axis,hashValue = \(self.stackView.axis.hashValue), axis,rawValue = \(self.stackView.axis.rawValue)")

        self.alignmentSegmentControl.selectedSegmentIndex = self.stackView.alignment.rawValue
        print("alignment,rawValue = \(self.stackView.alignment.rawValue)")

        self.distributionSegmentControl.selectedSegmentIndex = self.stackView.distribution.rawValue
        self.spacingLabel.text = NSString(format: "Spacing (%.1lf)",self.stackView.spacing) as String
        
        let headerSize : CGSize = self.tableView.tableHeaderView!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        self.tableView.tableHeaderView!.frame = CGRect(x: 0, y: 0, width: headerSize.width , height: headerSize.height)
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
        
    }
    
    @IBAction func axisSegmentControlValueChangedAction(_ sender: UISegmentedControl) {
//        let abc : UILayoutConstraintAxis!
        if sender.selectedSegmentIndex == 0 {
            self.stackView.axis = .horizontal
        }else{
            self.stackView.axis = .vertical
        }
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func alignmentSegmentControlValueChangedAction(_ sender: UISegmentedControl) {
//        self.stackView.alignment =
        if sender.selectedSegmentIndex == 0 {
            self.stackView.alignment = .fill
        }
        else if sender.selectedSegmentIndex == 1 {
            self.stackView.alignment = .leading
        }
        else if sender.selectedSegmentIndex == 2 {
            self.stackView.alignment = .firstBaseline
        }
        else if sender.selectedSegmentIndex == 3 {
            self.stackView.alignment = .center
        }
        else if sender.selectedSegmentIndex == 4 {
            self.stackView.alignment = .trailing
        }
//        else if sender.selectedSegmentIndex == 5 {
//            self.stackView.alignment = .LastBaseline
//        }
        else{
            self.stackView.alignment = .lastBaseline
        }
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func distributionSegmentControlValueChangedAction(_ sender: UISegmentedControl) {
//        self.stackView.distribution = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 0 {
            self.stackView.distribution = .fill
        }
        else if sender.selectedSegmentIndex == 1 {
            self.stackView.distribution = .fillEqually
        }
        else if sender.selectedSegmentIndex == 2 {
            self.stackView.distribution = .fillProportionally
        }
        else if sender.selectedSegmentIndex == 3 {
            self.stackView.distribution = .equalSpacing
        }
        else{
            self.stackView.distribution = .equalCentering
        }
//        else if sender.selectedSegmentIndex == 4 {
//            self.stackView.distribution = .EqualCentering
//        }
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func spacingSliderValueChangedAction(_ sender: UISlider) {
        self.stackView.spacing = CGFloat(sender.value)
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func hideAction(_ sender: AnyObject) {
        print("forkingdogImageView1 = \(self.forkingdogImageView.isHidden)")
//        self.forkingdogImageView.hidden ^= 1
        if self.forkingdogImageView.isHidden == true{
            self.forkingdogImageView.isHidden = false
        }
        else{
            self.forkingdogImageView.isHidden = true
        }
        print("forkingdogImageView2 = \(self.forkingdogImageView.isHidden)")
    }
    
    @IBAction func addAction(_ sender: AnyObject) {
        if self.mutableAddingViews == nil {
//            self.mutableAddingViews = [].mutableCopy() as! NSMutableArray
            self.mutableAddingViews = mutableCopy() as! NSMutableArray
        }
        
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.backgroundColor = UIColor(white: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1 )
        print("count = \(self.mutableAddingViews.count)")
        label.text = "\(self.mutableAddingViews.count)"
        self.stackView .addArrangedSubview(label)
        
        self.mutableAddingViews.add(label)
        self.updateFromStackViewAttributes()
        
    }
    
    @IBAction func removeAction(_ sender: AnyObject) {
        if self.mutableAddingViews.count == 0{
            return
        }
        let label = self.mutableAddingViews.lastObject
        (label as AnyObject).removeFromSuperview()
        self.mutableAddingViews.remove(label!)
        self.updateFromStackViewAttributes()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

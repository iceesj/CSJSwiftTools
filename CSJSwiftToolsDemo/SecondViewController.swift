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
        self.initCSJSTSetVC(.whiteColor(),bool: true, title: "界面二")
        
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
        
        let headerSize : CGSize = self.tableView.tableHeaderView!.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        self.tableView.tableHeaderView!.frame = CGRectMake(0, 0, headerSize.width , headerSize.height)
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
        
    }
    
    @IBAction func axisSegmentControlValueChangedAction(sender: UISegmentedControl) {
//        let abc : UILayoutConstraintAxis!
        if sender.selectedSegmentIndex == 0 {
            self.stackView.axis = .Horizontal
        }else{
            self.stackView.axis = .Vertical
        }
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func alignmentSegmentControlValueChangedAction(sender: UISegmentedControl) {
//        self.stackView.alignment =
        if sender.selectedSegmentIndex == 0 {
            self.stackView.alignment = .Fill
        }
        else if sender.selectedSegmentIndex == 1 {
            self.stackView.alignment = .Leading
        }
        else if sender.selectedSegmentIndex == 2 {
            self.stackView.alignment = .FirstBaseline
        }
        else if sender.selectedSegmentIndex == 3 {
            self.stackView.alignment = .Center
        }
        else if sender.selectedSegmentIndex == 4 {
            self.stackView.alignment = .Trailing
        }
//        else if sender.selectedSegmentIndex == 5 {
//            self.stackView.alignment = .LastBaseline
//        }
        else{
            self.stackView.alignment = .LastBaseline
        }
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func distributionSegmentControlValueChangedAction(sender: UISegmentedControl) {
//        self.stackView.distribution = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 0 {
            self.stackView.distribution = .Fill
        }
        else if sender.selectedSegmentIndex == 1 {
            self.stackView.distribution = .FillEqually
        }
        else if sender.selectedSegmentIndex == 2 {
            self.stackView.distribution = .FillProportionally
        }
        else if sender.selectedSegmentIndex == 3 {
            self.stackView.distribution = .EqualSpacing
        }
        else{
            self.stackView.distribution = .EqualCentering
        }
//        else if sender.selectedSegmentIndex == 4 {
//            self.stackView.distribution = .EqualCentering
//        }
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func spacingSliderValueChangedAction(sender: UISlider) {
        self.stackView.spacing = CGFloat(sender.value)
        self.updateFromStackViewAttributes()
    }
    
    @IBAction func hideAction(sender: AnyObject) {
        print("forkingdogImageView1 = \(self.forkingdogImageView.hidden)")
//        self.forkingdogImageView.hidden ^= 1
        if self.forkingdogImageView.hidden == true{
            self.forkingdogImageView.hidden = false
        }
        else{
            self.forkingdogImageView.hidden = true
        }
        print("forkingdogImageView2 = \(self.forkingdogImageView.hidden)")
    }
    
    @IBAction func addAction(sender: AnyObject) {
        if self.mutableAddingViews == nil {
            self.mutableAddingViews = [].mutableCopy() as! NSMutableArray
        }
        
        let label : UILabel = UILabel()
        label.font = UIFont.systemFontOfSize(25)
        label.backgroundColor = UIColor(white: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1 )
        print("count = \(self.mutableAddingViews.count)")
        label.text = "\(self.mutableAddingViews.count)"
        self.stackView .addArrangedSubview(label)
        
        self.mutableAddingViews.addObject(label)
        self.updateFromStackViewAttributes()
        
    }
    
    @IBAction func removeAction(sender: AnyObject) {
        if self.mutableAddingViews.count == 0{
            return
        }
        let label = self.mutableAddingViews.lastObject
        label?.removeFromSuperview()
        self.mutableAddingViews.removeObject(label!)
        self.updateFromStackViewAttributes()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

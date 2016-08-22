//
//  POPDetailTableviewViewController.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/8/18.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit


class POPDetailTableviewViewController: UIViewController {
    
    
    var springView : UIImageView!
    
    var layerPositionView : UIView!
    
    var viewFrameIMGView : UIImageView!
    
    var basicView : UIImageView!
    
    //判断String
    var panduanString : String!
    
    
    //CombinePOPbox
    var popView : UIImageView!
    var showPosition : CGRect!
    var hidePosition : CGRect!
    var isOpened : Bool!
    
    /*********************************************/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        view.backgroundColor = .whiteColor()
        self.navigationItem.title = panduanString
        print("panduanString = \(panduanString)")
        
        
        self.panduanMethod()
    }
    
    
    //MARK:
    func panduanMethod() {
        if panduanString == "kPOPLayerSize" {
            print("LayerSize - kPOPLayerSize")
            
            self.springView = UIImageView()
            self.springView.backgroundColor = .redColor()
            self.springView.userInteractionEnabled = true
            self.view.addSubview(self.springView)
            
            self.springView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(200)
//                make.right.equalTo(-10)
//                make.height.equalTo(100)
                make.size.equalTo(CGSizeMake(100.0, 100.0))
//                make.center.equalTo(view)
                make.centerX.equalTo(view.snp_centerX)
//                make.centerY.equalTo(view.snp_centerY)
            })
            
            let gestureForSpring = UITapGestureRecognizer()
            gestureForSpring.addTarget(self, action: #selector(POPDetailTableviewViewController.changeSize(_:)))
            self.springView.addGestureRecognizer(gestureForSpring)
            
        }else if panduanString == "kPOPLayerPosition" {
            print("LayerSize - kPOPLayerPosition")

            self.layerPositionView = UIView()
            self.layerPositionView.backgroundColor = UIColor.blueColor()
            self.layerPositionView.userInteractionEnabled = true
            self.view.addSubview(self.layerPositionView)
            
            self.layerPositionView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(-230)
                make.left.equalTo(20)
                
                make.width.equalTo(SCREEN_WIDTH_CSJST-40)
                make.height.equalTo(200)
                
            })
            
            let gestureForSpring = UITapGestureRecognizer()
            gestureForSpring.addTarget(self, action: #selector(POPDetailTableviewViewController.changeSize_kPOPLayerPosition(_:)))
            self.view.addGestureRecognizer(gestureForSpring)
            
            
        }
        else if panduanString == "kPOPViewFrame" {
            print("LayerSize - kPOPViewFrame")
            
            self.viewFrameIMGView = UIImageView()
            self.viewFrameIMGView.backgroundColor = UIColor.grayColor()
            self.viewFrameIMGView.userInteractionEnabled = true
            self.view.addSubview(self.viewFrameIMGView)
            
            self.viewFrameIMGView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(50)
                make.left.equalTo(50)
                
                make.width.equalTo(50)
                make.height.equalTo(50)
                
            })
            
            let gestureForSpring = UIPanGestureRecognizer()
            gestureForSpring.addTarget(self, action: #selector(POPDetailTableviewViewController.changeSize_kPOPViewFrame(_:)))
            self.view.addGestureRecognizer(gestureForSpring)
//            self.view.userInteractionEnabled = true
            
        }
        else if panduanString == "kPOPViewAlpha" {
            print("LayerSize - kPOPViewAlpha")
            
            self.basicView = UIImageView()
            self.basicView.backgroundColor = UIColor.blueColor()
            self.basicView.userInteractionEnabled = true
            self.view.addSubview(self.basicView)
            
            self.basicView.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(50)
                
                make.width.equalTo(100)
                make.height.equalTo(100)
                make.centerX.equalTo(view.snp_centerX)
            })
            
            let gestureForSpring = UITapGestureRecognizer()
            gestureForSpring.addTarget(self, action: #selector(POPDetailTableviewViewController.changeSize_kPOPViewAlpha(_:)))
            self.view.addGestureRecognizer(gestureForSpring)
        }else{
            print("CombineAnimation-POPbox")
            isOpened = false
            
            //popbox
            self.showPosition = CGRectMake(SCREEN_WIDTH_CSJST-155, 5, 150, 160)
            self.hidePosition = CGRectMake(SCREEN_WIDTH_CSJST, 5, 0, 0)
            
            self.popView = UIImageView()
            self.popView.frame = self.hidePosition
            self.popView.backgroundColor = UIColor.blueColor()
            self.view.addSubview(self.popView)
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem (title: "+", style: UIBarButtonItemStyle.Done, target: self, action: #selector(POPDetailTableviewViewController.showPop))
            
            
        }
    }
    
    /*************************************************************************************************************/
    
    //MAKR:kPOPLayerSize
    func changeSize(tap :UITapGestureRecognizer) {
        let springAnimation : POPSpringAnimation = POPSpringAnimation(propertyNamed:kPOPLayerSize)
        let rect : CGRect = self.springView.frame
        if rect.size.width == 100 {
            springAnimation.toValue = NSValue(CGSize: CGSizeMake(300, 300))
        }
        else{
            springAnimation.toValue = NSValue(CGSize: CGSizeMake(100, 100))
        }
        
        //弹性值
        springAnimation.springBounciness = 20.0
        //弹性速度
        springAnimation.springSpeed = 20.0
        
        self.springView.layer .pop_addAnimation(springAnimation, forKey: "changesize")
        
    }
    
    
    func changeSize_kPOPLayerPosition(tap :UITapGestureRecognizer) {
        let springAnimation = POPSpringAnimation (propertyNamed: kPOPLayerPosition)
        let point = self.layerPositionView.center
        if point.y == 240 {
            springAnimation.toValue = NSValue (CGPoint: CGPointMake(point.x, -130))
        }
        else{
            springAnimation.toValue = NSValue (CGPoint: CGPointMake(point.x, 240))
        }
        //弹性值
        springAnimation.springBounciness = 20.0
        //弹性速度
        springAnimation.springSpeed = 20.0
        
        self.layerPositionView .pop_addAnimation(springAnimation, forKey: "changeposition")
        
    }
    
    
    //MARK:kPOPViewFrame
    func changeSize_kPOPViewFrame(tap: UITapGestureRecognizer){
        let springAnimation = POPSpringAnimation (propertyNamed: kPOPViewFrame)
        let point : CGPoint = tap.locationInView(self.view)
        springAnimation.toValue = NSValue (CGRect: CGRectMake(0, 0, point.x, point.y))
        //弹性值
        springAnimation.springBounciness = 20.0
        //弹性速度
        springAnimation.springSpeed = 20.0
        
        self.viewFrameIMGView .pop_addAnimation(springAnimation, forKey: "changeframe")
        
    }
    
    /*************************************************************************************************************/
    
    //MARK:kPOPViewAlpha
    func changeSize_kPOPViewAlpha(tap: UITapGestureRecognizer){
        let anim = POPBasicAnimation (propertyNamed: kPOPViewAlpha)
        anim.timingFunction = CAMediaTimingFunction (name: kCAMediaTimingFunctionEaseInEaseOut)
        let alpha = self.basicView.alpha
        if alpha == 1.0 {
            anim.toValue = 0.0
        }else{
            anim.toValue = 1.0
        }
        
        self.basicView .pop_addAnimation(anim, forKey: "alpha")
        
    }
    
    /*************************************************************************************************************/
    
    //MARK: POP
    func showPop() {
        if isOpened==true {
            self.hidePop()
            return
        }
        isOpened = true
        
        let positionAnimation = POPSpringAnimation (propertyNamed: kPOPViewFrame)
        positionAnimation.fromValue = NSValue (CGRect: self.hidePosition)
        positionAnimation.toValue = NSValue (CGRect: self.showPosition)
        positionAnimation.springBounciness = 15.0
        positionAnimation.springSpeed = 20.0
        self.popView.pop_addAnimation(positionAnimation, forKey: "frameAnimation")
        
    }
    
    func hidePop() {
        let positionAnimation = POPSpringAnimation (propertyNamed: kPOPViewFrame)
        positionAnimation.fromValue = NSValue (CGRect: showPosition)
        positionAnimation.toValue = NSValue (CGRect: hidePosition)
        self.popView.pop_addAnimation(positionAnimation, forKey: "frameAnimation")
        
        isOpened = false
    }
    
    
    
    
    
}




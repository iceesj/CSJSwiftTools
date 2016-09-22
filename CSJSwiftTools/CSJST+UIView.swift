//
//  CSJST+UIView.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension UIView
{
    //MARK: Circle圆形
    public func radius(_ adius:Float){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(adius)
    }
    
    public func makeCircle(){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(self.bounds.size.width/2)
    }
    
    
    //MARK: Constraint约束
    public func widthConstraints() -> Array<NSLayoutConstraint>{
        var result = [NSLayoutConstraint]()
        for c in self.constraints{
            if c.firstAttribute == .width &&
                (c.firstItem as? NSObject) == self &&
                c.secondAttribute == .notAnAttribute &&
                (c.secondItem as? NSObject) == nil{
                result.append(c)
            }
        }
        return result
    }
    
    public func heightConstraints() -> Array<NSLayoutConstraint>
    {
        var result = [NSLayoutConstraint]()
        for c in self.constraints
        {
            if c.firstAttribute == .height &&
                (c.firstItem as? NSObject) == self &&
                c.secondAttribute == .notAnAttribute &&
                (c.secondItem as? NSObject) == nil
            {
                result.append(c)
            }
        }
        return result
    }
    
    public func fitWidth()
    {
        let size = self.sizeThatFits(CGSize.zero)
        changeWidth(size.width)
    }
    
    public func fitHeight()
    {
        let size = self.sizeThatFits(CGSize.zero)
        changeWidth(size.height)
    }
    public func changeWidth(_ width:CGFloat)
    {
        self.widthConstraints().forEach {
            $0.constant = width
        }
    }
    
    public func changeHeight(_ height:CGFloat)
    {
        self.widthConstraints().forEach {
            $0.constant = height
        }
    }
    
    
    public func constraint(_ identifier:String) -> NSLayoutConstraint?
    {
        for c in self.constraints
        {
            if c.identifier == identifier
            {
                return c
            }
        }
        
        return nil
    }
    
    public func constraintInSubviews(_ identifier:String) -> NSLayoutConstraint?
    {
        var c = self.constraint(identifier)
        
        if c != nil
        {
            return c
        }else
        {
            for subview in self.subviews
            {
                c = subview.constraintInSubviews(identifier)
                if c != nil
                {
                    return c
                }
            }
        }
        return nil
    }
    
    
    //MARK: Render
    enum RenderType {
        case uiView
        case uiLabel
        case uiImageView
        case uiButton
        case uiSwitch
        case uiSegmentedControl
        case uiSlider
        case uiActivityIndicatorView
        case uiProgressView
        case uiStepper
        case uiTableView
        case uiCollectionView
        case uiScrollView
        case uiWebView
        case uiTextView
        case uiTextField
    }
    
    subscript (tag:Int) -> AnyObject?
        {
        get {
            return self.viewWithTag(tag)
        }
    }
    
    
    func view(_ tag:Int) -> UIView?
    {
        return self[tag] as? UIView
    }
    func lable(_ tag:Int) -> UILabel?
    {
        return self[tag] as? UILabel
    }
    func imageView(_ tag:Int) -> UIImageView?
    {
        return self[tag] as? UIImageView
    }
    func button(_ tag:Int) -> UIButton?
    {
        return self[tag] as? UIButton
    }
    func textView(_ tag:Int) -> UITextView?
    {
        return self[tag] as? UITextView
    }
    func textField(_ tag:Int) -> UITextField?
    {
        return self[tag] as? UITextField
    }
    func segmentedControl(_ tag:Int) -> UISegmentedControl?
    {
        return self[tag] as? UISegmentedControl
    }
    
    func slider(_ tag:Int) -> UISlider?
    {
        return self[tag] as? UISlider
    }
    
    func activityIndicatorView(_ tag:Int) -> UIActivityIndicatorView?
    {
        return self[tag] as? UIActivityIndicatorView
    }
    
    func progressView(_ tag:Int) -> UIProgressView?
    {
        return self[tag] as? UIProgressView
    }
    
    func stepper(_ tag:Int) -> UIStepper?
    {
        return self[tag] as? UIStepper
    }
    
    func tableView(_ tag:Int) -> UITableView?
    {
        return self[tag] as? UITableView
    }
    
    func collectionView(_ tag:Int) -> UICollectionView?
    {
        return self[tag] as? UICollectionView
    }
    
    func scrollView(_ tag:Int) -> UIScrollView?
    {
        return self[tag] as? UIScrollView
    }
    
    func webView(_ tag:Int) -> UIWebView?
    {
        return self[tag] as? UIWebView
    }
    
    func tap(_ target: AnyObject?, action: Selector) -> UITapGestureRecognizer
    {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        return tap
    }
    
    
    class func xib(_ xib:String) -> UIView?
    {
        let views = Bundle.main.loadNibNamed(xib, owner: nil, options: nil)
        return views?.first as? UIView
    }
    
    
    func renderLabels(_ data:Dictionary<Int,String>) -> UIView
    {
        for (tag,value) in data
        {
            self.lable(tag)?.text = value
        }
        return self
    }
    
    //MARK: ZXQuartz
    //矩形、圆角矩形 rect
    /*
    func zx_drawRect(_ rect:CGRect,radius:Float=0,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        let context = UIGraphicsGetCurrentContext()
        let path    = self.path(rect, radius: radius)
        context?.addPath(path)
        context?.drawPath(using: fillMode)
    }
    
    
    //Polygon
    func drawPolygon(_ points:Array<CGPoint>,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        assert(points.count >= 2, "The count of points must be more than 2.")
        
        let context = UIGraphicsGetCurrentContext()
        let start = points.first!
        
        for (i,point) in points.enumerated()
        {
            if i == 0
            {
                context?.move(to: CGPoint(x: point.x, y: point.y));
            }
            else if i == points.count - 1
            {
                context?.addLine(to: CGPoint(x: point.x, y: point.y));
            }else
            {
                context?.addLine(to: CGPoint(x: start.x, y: start.y));
            }
        }
        context?.drawPath(using: fillMode)
    }
    
    
    func drawCircle(_ center:CGPoint,radius:Float,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        drawArc(center, radius: radius, start: 0, end: Float(M_PI*2),fillMode:fillMode)
    }
    func drawArc(_ center:CGPoint,radius:Float,start:Float,end:Float,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        assert(radius > 0, "The cradius must be more than 0.")
        
        let context = UIGraphicsGetCurrentContext()
        
        let r = CGFloat(radius)
        CGContextAddArc(context,
                        center.x,
                        center.y,
                        r,
                        CGFloat(start),
                        CGFloat(end),
                        0);
        context?.drawPath(using: fillMode)
    }
    
    func drawBezierCurve(_ start:CGPoint,end:CGPoint,control1:CGPoint,control2:CGPoint,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: start.x, y: start.y));
        CGContextAddCurveToPoint(context, control1.x, control1.y, control1.x, control1.y, end.x, end.y)
        context?.drawPath(using: fillMode)
    }
    
    func drawLine(_ start:CGPoint,end:CGPoint,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        drawLines([start,end], fillMode: fillMode)
    }
    func drawLines(_ points:Array<CGPoint>,fillMode:CGPathDrawingMode=CGPathDrawingMode.fillStroke)
    {
        assert(points.count >= 0, "The count of points must be more than 2.")
        
        let context = UIGraphicsGetCurrentContext()
        
        for (i,point) in points.enumerated()
        {
            if i == 0
            {
                context?.move(to: CGPoint(x: point.x, y: point.y));
            }else
            {
                context?.addLine(to: CGPoint(x: point.x, y: point.y));
            }
        }
        context?.drawPath(using: fillMode)
    }
    
    
    func drawImage(_ image:UIImage,point:CGPoint, blendMode: CGBlendMode = CGBlendMode.normal, alpha: CGFloat=1)
    {
        image.draw(at: point, blendMode: blendMode, alpha: alpha)
    }
    func drawString()
    {
        assert(false, "unfinish.")
    }
    
    func drawShadow(_ offset:CGSize, blur:CGFloat, color:CGColor?=nil)
    {
        let context = UIGraphicsGetCurrentContext()
        context?.setShadow(offset: offset, blur: blur, color: color)
    }
    
    func path(_ frame:CGRect,radius:Float) -> CGMutablePath
    {
        
        var x1,x2,x3,x4,y1,y2,y3,y4,y5,y6,y7,y8:CGPoint
        //y为4个控制点
        //从左上角顶点开始，顺时针旋转,x1->y1->y2->x2
        
        let r = CGFloat(radius)
        
        x1 = frame.origin;
        x2 = CGPoint(x: frame.origin.x+frame.size.width, y: frame.origin.y);
        x3 = CGPoint(x: frame.origin.x+frame.size.width, y: frame.origin.y+frame.size.height);
        x4 = CGPoint(x: frame.origin.x                 , y: frame.origin.y+frame.size.height);
        
        
        y1 = CGPoint(x: frame.origin.x+r, y: frame.origin.y);
        y2 = CGPoint(x: frame.origin.x+frame.size.width-r, y: frame.origin.y);
        y3 = CGPoint(x: frame.origin.x+frame.size.width, y: frame.origin.y+r);
        y4 = CGPoint(x: frame.origin.x+frame.size.width, y: frame.origin.y+frame.size.height-r);
        
        y5 = CGPoint(x: frame.origin.x+frame.size.width-r, y: frame.origin.y+frame.size.height);
        y6 = CGPoint(x: frame.origin.x+r, y: frame.origin.y+frame.size.height);
        y7 = CGPoint(x: frame.origin.x, y: frame.origin.y+frame.size.height-r);
        y8 = CGPoint(x: frame.origin.x, y: frame.origin.y+r);
        
        let pathRef = CGMutablePath()
        
        if (r <= 0) {
            
            CGPathMoveToPoint(pathRef,    nil, x1.x,x1.y);
            CGPathAddLineToPoint(pathRef, nil, x2.x,x2.y);
            CGPathAddLineToPoint(pathRef, nil, x3.x,x3.y);
            CGPathAddLineToPoint(pathRef, nil, x4.x,x4.y);
        }else
        {
            CGPathMoveToPoint(pathRef,    nil, y1.x,y1.y);
            
            CGPathAddLineToPoint(pathRef, nil, y2.x,y2.y);
            CGPathAddArcToPoint(pathRef, nil,  x2.x,x2.y,y3.x,y3.y,r);
            
            CGPathAddLineToPoint(pathRef, nil, y4.x,y4.y);
            CGPathAddArcToPoint(pathRef, nil,  x3.x,x3.y,y5.x,y5.y,r);
            
            CGPathAddLineToPoint(pathRef, nil, y6.x,y6.y);
            CGPathAddArcToPoint(pathRef, nil,  x4.x,x4.y,y7.x,y7.y,r);
            
            CGPathAddLineToPoint(pathRef, nil, y8.x,y8.y);
            CGPathAddArcToPoint(pathRef, nil,  x1.x,x1.y,y1.x,y1.y,r);
            
        }
        
        
        pathRef.closeSubpath();
        return pathRef;
    }
    */
    
    func findUIViewController() -> UIViewController? {
        //        id nextResponder = [self nextResponder];
        //        if ([nextResponder isKindOfClass:[UIViewController class]]) {
        //            return nextResponder;
        //        } else if ([nextResponder isKindOfClass:[UIView class]]) {
        //            return [nextResponder traverseResponderChainForUIViewController];
        //        } else {
        //            return nil;
        //        }
        
        return findForUIViewControllerIteratively()
        
    }
    
    func findForUIViewControllerIteratively() -> UIViewController?{
        if let nextResponder = self.next{
            if nextResponder.isKind(of: UIViewController.self){
                return nextResponder as? UIViewController
            }else if nextResponder.isKind(of: UIView.self){
                return (nextResponder as? UIView)?.findForUIViewControllerIteratively()
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    
    
    
}

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
    public func radius(adius:Float){
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
            if c.firstAttribute == .Width &&
                (c.firstItem as? NSObject) == self &&
                c.secondAttribute == .NotAnAttribute &&
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
            if c.firstAttribute == .Height &&
                (c.firstItem as? NSObject) == self &&
                c.secondAttribute == .NotAnAttribute &&
                (c.secondItem as? NSObject) == nil
            {
                result.append(c)
            }
        }
        return result
    }
    
    public func fitWidth()
    {
        let size = self.sizeThatFits(CGSizeZero)
        changeWidth(size.width)
    }
    
    public func fitHeight()
    {
        let size = self.sizeThatFits(CGSizeZero)
        changeWidth(size.height)
    }
    public func changeWidth(width:CGFloat)
    {
        self.widthConstraints().forEach {
            $0.constant = width
        }
    }
    
    public func changeHeight(height:CGFloat)
    {
        self.widthConstraints().forEach {
            $0.constant = height
        }
    }
    
    
    public func constraint(identifier:String) -> NSLayoutConstraint?
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
    
    public func constraintInSubviews(identifier:String) -> NSLayoutConstraint?
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
        case UIView
        case UILabel
        case UIImageView
        case UIButton
        case UISwitch
        case UISegmentedControl
        case UISlider
        case UIActivityIndicatorView
        case UIProgressView
        case UIStepper
        case UITableView
        case UICollectionView
        case UIScrollView
        case UIWebView
        case UITextView
        case UITextField
    }
    
    subscript (tag:Int) -> AnyObject?
        {
        get {
            return self.viewWithTag(tag)
        }
    }
    
    
    func view(tag:Int) -> UIView?
    {
        return self[tag] as? UIView
    }
    func lable(tag:Int) -> UILabel?
    {
        return self[tag] as? UILabel
    }
    func imageView(tag:Int) -> UIImageView?
    {
        return self[tag] as? UIImageView
    }
    func button(tag:Int) -> UIButton?
    {
        return self[tag] as? UIButton
    }
    func textView(tag:Int) -> UITextView?
    {
        return self[tag] as? UITextView
    }
    func textField(tag:Int) -> UITextField?
    {
        return self[tag] as? UITextField
    }
    func segmentedControl(tag:Int) -> UISegmentedControl?
    {
        return self[tag] as? UISegmentedControl
    }
    
    func slider(tag:Int) -> UISlider?
    {
        return self[tag] as? UISlider
    }
    
    func activityIndicatorView(tag:Int) -> UIActivityIndicatorView?
    {
        return self[tag] as? UIActivityIndicatorView
    }
    
    func progressView(tag:Int) -> UIProgressView?
    {
        return self[tag] as? UIProgressView
    }
    
    func stepper(tag:Int) -> UIStepper?
    {
        return self[tag] as? UIStepper
    }
    
    func tableView(tag:Int) -> UITableView?
    {
        return self[tag] as? UITableView
    }
    
    func collectionView(tag:Int) -> UICollectionView?
    {
        return self[tag] as? UICollectionView
    }
    
    func scrollView(tag:Int) -> UIScrollView?
    {
        return self[tag] as? UIScrollView
    }
    
    func webView(tag:Int) -> UIWebView?
    {
        return self[tag] as? UIWebView
    }
    
    func tap(target: AnyObject?, action: Selector) -> UITapGestureRecognizer
    {
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.userInteractionEnabled = true
        self.addGestureRecognizer(tap)
        return tap
    }
    
    
    class func xib(xib:String) -> UIView?
    {
        let views = NSBundle.mainBundle().loadNibNamed(xib, owner: nil, options: nil)
        return views.first as? UIView
    }
    
    
    func renderLabels(data:Dictionary<Int,String>) -> UIView
    {
        for (tag,value) in data
        {
            self.lable(tag)?.text = value
        }
        return self
    }
    
    //MARK: ZXQuartz
    //矩形、圆角矩形 rect
    func zx_drawRect(rect:CGRect,radius:Float=0,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
    {
        let context = UIGraphicsGetCurrentContext()
        let path    = self.path(rect, radius: radius)
        CGContextAddPath(context, path)
        CGContextDrawPath(context, fillMode)
    }
    
    
    //Polygon
    func drawPolygon(points:Array<CGPoint>,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
    {
        assert(points.count >= 2, "The count of points must be more than 2.")
        
        let context = UIGraphicsGetCurrentContext()
        let start = points.first!
        
        for (i,point) in points.enumerate()
        {
            if i == 0
            {
                CGContextMoveToPoint(context, point.x, point.y);
            }
            else if i == points.count - 1
            {
                CGContextAddLineToPoint(context, point.x,point.y);
            }else
            {
                CGContextAddLineToPoint(context, start.x,start.y);
            }
        }
        CGContextDrawPath(context, fillMode)
    }
    
    
    func drawCircle(center:CGPoint,radius:Float,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
    {
        drawArc(center, radius: radius, start: 0, end: Float(M_PI*2),fillMode:fillMode)
    }
    func drawArc(center:CGPoint,radius:Float,start:Float,end:Float,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
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
        CGContextDrawPath(context, fillMode)
    }
    
    func drawBezierCurve(start:CGPoint,end:CGPoint,control1:CGPoint,control2:CGPoint,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
    {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextMoveToPoint(context, start.x, start.y);
        CGContextAddCurveToPoint(context, control1.x, control1.y, control1.x, control1.y, end.x, end.y)
        CGContextDrawPath(context, fillMode)
    }
    
    func drawLine(start:CGPoint,end:CGPoint,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
    {
        drawLines([start,end], fillMode: fillMode)
    }
    func drawLines(points:Array<CGPoint>,fillMode:CGPathDrawingMode=CGPathDrawingMode.FillStroke)
    {
        assert(points.count >= 0, "The count of points must be more than 2.")
        
        let context = UIGraphicsGetCurrentContext()
        
        for (i,point) in points.enumerate()
        {
            if i == 0
            {
                CGContextMoveToPoint(context, point.x, point.y);
            }else
            {
                CGContextAddLineToPoint(context, point.x,point.y);
            }
        }
        CGContextDrawPath(context, fillMode)
    }
    
    
    func drawImage(image:UIImage,point:CGPoint, blendMode: CGBlendMode = CGBlendMode.Normal, alpha: CGFloat=1)
    {
        image.drawAtPoint(point, blendMode: blendMode, alpha: alpha)
    }
    func drawString()
    {
        assert(false, "unfinish.")
    }
    
    func drawShadow(offset:CGSize, blur:CGFloat, color:CGColor?=nil)
    {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetShadowWithColor(context, offset, blur, color)
    }
    
    func path(frame:CGRect,radius:Float) -> CGMutablePath
    {
        
        var x1,x2,x3,x4,y1,y2,y3,y4,y5,y6,y7,y8:CGPoint
        //y为4个控制点
        //从左上角顶点开始，顺时针旋转,x1->y1->y2->x2
        
        let r = CGFloat(radius)
        
        x1 = frame.origin;
        x2 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y);
        x3 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height);
        x4 = CGPointMake(frame.origin.x                 , frame.origin.y+frame.size.height);
        
        
        y1 = CGPointMake(frame.origin.x+r, frame.origin.y);
        y2 = CGPointMake(frame.origin.x+frame.size.width-r, frame.origin.y);
        y3 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+r);
        y4 = CGPointMake(frame.origin.x+frame.size.width, frame.origin.y+frame.size.height-r);
        
        y5 = CGPointMake(frame.origin.x+frame.size.width-r, frame.origin.y+frame.size.height);
        y6 = CGPointMake(frame.origin.x+r, frame.origin.y+frame.size.height);
        y7 = CGPointMake(frame.origin.x, frame.origin.y+frame.size.height-r);
        y8 = CGPointMake(frame.origin.x, frame.origin.y+r);
        
        let pathRef = CGPathCreateMutable()
        
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
        
        
        CGPathCloseSubpath(pathRef);
        return pathRef;
    }
    
}
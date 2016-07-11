//
//  CSJST+UIImageView.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit

public extension UIImageView
{
    /**
     animation
     */
    public func animation(imageNames:Array<String>,time:NSTimeInterval=0.1,`repeat`:Int=0)
    {
        var images = [UIImage]()
        
        for name in imageNames
        {
            let image = UIImage(named: name)
            images.append(image!)
        }
        self.animationImages = images
        self.animationDuration = NSTimeInterval(time * NSTimeInterval(imageNames.count))
        self.animationRepeatCount = `repeat`
        self.startAnimating()
    }
}
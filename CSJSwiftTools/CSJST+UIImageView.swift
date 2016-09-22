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
    public func animation(_ imageNames:Array<String>,time:TimeInterval=0.1,repeat:Int=0)
    {
        var images = [UIImage]()
        
        for name in imageNames
        {
            let image = UIImage(named: name)
            images.append(image!)
        }
        self.animationImages = images
        self.animationDuration = TimeInterval(time * TimeInterval(imageNames.count))
        self.animationRepeatCount = `repeat`
        self.startAnimating()
    }
}

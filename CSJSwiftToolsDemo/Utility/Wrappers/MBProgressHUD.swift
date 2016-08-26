//
//  MBProgressHUD.swift
//  xs1happ
//
//  Created by PengZhao on 15/12/12.
//  Copyright © 2015年 xs1h. All rights reserved.
//

import UIKit
import MBProgressHUD
import Reachability

//HUD
extension MBProgressHUD {
    
    class func showWithStatus(status: String, onView view: UIView) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = .Text
        hud.yOffset = Float(CGRectGetHeight(view.bounds) / 2.0 + view.bounds.origin.y) - 80
        hud.labelText = status
        hud.labelFont = CSJST_GlobalConstants.HUDFont
        hud.margin = 11.0
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7 * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()) {
            MBProgressHUD.hideHUDForView(view, animated: true)
        }
    }
    
    class func showWithNetworkErrorOnView(view: UIView) {
        if Reachability.reachabilityForInternetConnection().isReachable() {
            showWithStatus("服务器连接异常", onView: view)
        } else {
            showWithStatus("网络中断", onView: view)
        }
    }
}

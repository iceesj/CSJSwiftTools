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
    
    class func showWithStatus(_ status: String, onView view: UIView) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.mode = .text
        hud?.yOffset = Float(view.bounds.height / 2.0 + view.bounds.origin.y) - 80
        hud?.labelText = status
        hud?.labelFont = CSJST_GlobalConstants.HUDFont
        hud?.margin = 11.0
        
        let popTime = DispatchTime.now() + Double(Int64(0.7 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    class func showWithNetworkErrorOnView(_ view: UIView) {
        if Reachability.forInternetConnection().isReachable() {
            showWithStatus("服务器连接异常", onView: view)
        } else {
            showWithStatus("网络中断", onView: view)
        }
    }
}

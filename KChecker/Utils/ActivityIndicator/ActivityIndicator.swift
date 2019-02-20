//
//  ActivityIndicator.swift
//  BaoLi
//
//  Created by Liao Qiang on 2018/1/9.
//  Copyright © 2018年 BaoLi. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator: NSObject {
    
    //添加loading
    @objc static func progressHudShowWithView(onView view:UIView) -> Void {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    //移除loading
    @objc static func progresshHUDRemovedWithView(onView view:UIView) -> Void {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

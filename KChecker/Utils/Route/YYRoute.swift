//
//  YYRoute.swift
//  KChecker
//  路由
//  Created by LiaoQiang on 2019/1/25.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class YYRoute: NSObject {
    class func pushToController(_ vcName:String,data:AnyObject?) {
        var cls = NSClassFromString(vcName) as? UIViewController.Type
        if cls == nil {
            cls = NSClassFromString("KChecker."+vcName) as? UIViewController.Type
        }
        let vc = cls!.init()
        self.pushToController(vc, data: data)
    }
    
    class func pushToController(_ vc:UIViewController,data:AnyObject?) {
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.nav.pushViewController(vc, animated: true)
        if data != nil {
            vc.setValue(data!, forKey: "baseData")
        }
    }
}

//
//  YYRoute.swift
//  KChecker
//  路由
//  Created by LiaoQiang on 2019/1/25.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class YYRoute: NSObject {
    @objc class func pushToController(_ vcName:String,data:AnyObject?) {
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
    
    //pop应该也可以写在这里面，似乎没什么不好
    static func pop2() {
        let app = UIApplication.shared.delegate as? AppDelegate
        let vcs = app?.nav.viewControllers
        if let vcs = vcs {
            app?.nav.popToViewController(vcs[vcs.count-3], animated: true)
        }
        else {
            print("层级不够，无法跳转到爷爷vc")
        }
    }
    
    //pop应该也可以写在这里面，似乎没什么不好
    static func pop() {
        let app = UIApplication.shared.delegate as? AppDelegate
        let vcs = app?.nav.viewControllers
        if let vcs = vcs,vcs.count >= 2 {
            app?.nav.popToViewController(vcs[vcs.count-2], animated: true)
        }
        else {
            print("层级不够，无法跳转到爸爸vc")
        }
    }
    
    //pop到根目录
    static func popToRoot() {
        let app = UIApplication.shared.delegate as? AppDelegate
        app?.nav.popToRootViewController(animated: true)
    }
}

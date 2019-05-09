//
//  ResendRequest.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/5/9.
//

import UIKit
import SwiftyJSON

class ResendRequest: NSObject {
    
    var group = DispatchGroup()
    let lock = NSLock()
    
    //再次发送缓存的请求
    func resendRequest() {
        
        self.lock.lock()
        var localRequest:[String:JSON]?
        do {
            localRequest = try YYNCache.requestStorage?.object(forKey: "request").dictionaryValue
        }
        catch {
            localRequest = [String:JSON]()
        }
        
        localRequest?.keys.forEach({ (key) in
            let param = localRequest?[key]?.dictionaryObject
            group.enter()
            YYNSessionManager.default()?.method("post", urlString: key, andParams: param, andHttpHeaders: [:], success: { (ret) in
                if let ret = ret as? [String:AnyObject] {
                    if Int(truncating: ret["code"] as! NSNumber) == 200 {
                        ProgressHUD.showMessage("\(String(describing: param?["localTitle"]))提交成功")
                        self.removeRequestForKey(key)
                    }
                    else {
                        ProgressHUD.showMessage("\(String(describing: param?["localTitle"]))提交失败，原因：\(String(describing: ret["msg"]))")
                    }
                }
                self.group.leave()
            }, failure: { (err) in
                ProgressHUD.showMessage("网络连接中断，\(String(describing: param?["localTitle"]))提交失败，待有网络再次提交")
                self.group.leave()
            })
        })
        group.notify(queue: DispatchQueue.main) {
            self.lock.unlock()
        }
    }
    
    //移除提交成功的request
    func removeRequestForKey(_ key:String) {
        var localRequest:[String:JSON]?
        do {
            localRequest = try YYNCache.requestStorage?.object(forKey: "request").dictionaryValue
        }
        catch {
            localRequest = [String:JSON]()
        }
        localRequest?.removeValue(forKey: key)
        try? YYNCache.requestStorage?.setObject(JSON(localRequest!), forKey: "request")
    }
}

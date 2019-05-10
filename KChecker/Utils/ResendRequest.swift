//
//  ResendRequest.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/5/9.
//

import UIKit
import SwiftyJSON

class ResendRequest: NSObject {
    
    let reach = Reachability(hostName: "http://www.baidu.com")
    var group = DispatchGroup()
    let lock = NSLock()
    static let shared = ResendRequest()
    
    override init() {
        super.init()
        reach?.startNotifier()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_ :)), name: NSNotification.Name("kReachabilityChangedNotification"), object: nil)
    }
    
    @objc func reachabilityChanged(_ noti:Notification) {
        resendRequest()
    }
    
    deinit {
        reach?.stopNotifier()
        NotificationCenter.default.removeObserver(self)
    }
    
    //再次发送缓存的请求
    func resendRequest() {
        if reach?.currentReachabilityStatus() == .NotReachable {
            //print("无网络连接")
            return
        }
        
        self.lock.lock()
        var localRequest:[String:JSON]?
        do {
            localRequest = try YYNCache.requestStorage?.object(forKey: "request").dictionaryValue
        }
        catch {
            localRequest = [String:JSON]()
            //print("没有待提交请求")
            return
        }
        
        localRequest?.keys.forEach({ (key) in
            let param = localRequest?[key]?.dictionaryObject
            group.enter()
            let session = YYNSessionManager.default()
            if let style = param!["style"] as? String,style == "AFJSONRequestSerializer" {
                session?.requestSerializer = AFJSONRequestSerializer()
            }
            session?.method("post", urlString: key, andParams: param, andHttpHeaders: [:], success: { (ret) in
                if let ret = ret as? [String:AnyObject] {
                    if Int(truncating: ret["code"] as! NSNumber) == 200 {
                        ProgressHUD.showMessage("\(param!["localTitle"] as? String ?? "未知填报")提交成功")
                        self.removeRequestForKey(key)
                    }
                    else {
                        ProgressHUD.showMessage("\(param!["localTitle"] as? String ?? "未知填报")提交失败，原因：\(String(describing: ret["msg"]))")
                    }
                }
                self.group.leave()
            }, failure: { (err) in
                ProgressHUD.showMessage("网络连接中断，“\(param!["localTitle"] as? String ?? "未知填报")”提交失败，待有网络再次提交")
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

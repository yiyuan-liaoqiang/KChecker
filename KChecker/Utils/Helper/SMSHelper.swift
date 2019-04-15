//
//  SMSHelper.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/4/9.
//  Copyright © 2019 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit

class SMSHelper: NSObject {
    //登录验证码
    static func getLoginCode(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "sms/loginVericode", andParams: param, andHttpHeaders: [:], success: { (ret ) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0?["data"])
        }, failure: { (err) in
            callback(err as? String, nil)
        })
    }
    
    //重制密码验证码
    static func getResetPwdCode(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "sms/resetPwdVericode", andParams: param, andHttpHeaders: [:], success: { (ret ) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0?["data"])
        }, failure: { (err) in
            callback(err as? String, nil)
        })
    }
    
    //获取注册验证码
    static func getRegisterCode(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "sms/registerVericode", andParams: param, andHttpHeaders: [:], success: { (ret ) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0?["data"])
        }, failure: { (err) in
            callback(err as? String, nil)
        })
    }
}

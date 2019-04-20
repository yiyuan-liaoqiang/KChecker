//
//  AccountHelper.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/3/27.
//  Copyright © 2019 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccountHelper: NSObject {
    
    static var isLogin:Bool {
        get {
            return (try? YYNCache.userRelatedStorage?.object(forKey: "isLogin").boolValue) == true
        }
    }
    
    @objc static var token:String {
        get {
            var token:String?
            do {
                token = try YYNCache.userRelatedStorage?.object(forKey: "token").string
            }
            catch {
                token = ""
            }
            return token!
        }
    }
    
    class var userInfo:UserModel? {
        get {
            let user = UserDefaults.standard.value(forKey: "userInfo") as? [String:AnyObject]
            guard user != nil else {
                return nil
            }
            return UserModel.deserialize(from: user)
        }
    }
    
    static func synchronizeUserInfo(_ model:UserModel!) {
        let userDic = model.toJSON()
        
        UserDefaults.standard.setValue(userDic, forKey: "userInfo")
        UserDefaults.standard.synchronize()
    }
    
    //获取任务列表
    static func taskList(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "tasks", andParams: param, andHttpHeaders: nil, success: { (ret) in
            guard let data = ret as? [AnyObject] else {
                callback("请求失败", nil)
                return
            }
            callback(nil, data as AnyObject)
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    
    //获取检点记录列表
    static func checkList(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "check/history", andParams: param, andHttpHeaders: nil, success: { (ret) in
            guard let data = ret as? [AnyObject] else {
                callback("请求失败", nil)
                return
            }
            callback(nil, data as AnyObject)
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    //    获取当前设备点检计划
    static func checkProject(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "facility/{facilityId}/plan/check", andParams: param, andHttpHeaders: nil, success: { (ret) in
            guard let data = ret as? [AnyObject] else {
                callback("请求失败", nil)
                return
            }
            callback(nil, data as AnyObject)
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    //密码登录
    static func loginWithPwd(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("post", urlString: "signIn", andParams: param, andHttpHeaders: nil, success: { (ret) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0?["data"])
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    
    //验证码登录
    static func loginWithVericode(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "user/vericodeLogin", andParams: param, andHttpHeaders: nil, success: { (ret) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0?["data"])
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    
    //重置验证码
    static func resetPwdByVericode(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("post", urlString: "user/resetPwd", andParams: param, andHttpHeaders: nil, success: { (ret) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0?["data"])
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    
    //企业登录，获取企业信息
    static func enterpriseInfo(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "user/enterpriseInfo", andParams: param, andHttpHeaders: nil, success: { (ret) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret as AnyObject)
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
    
    //job finder登录，获取简历信息
    static func resumeInfo(_ param:Dictionary<String,AnyObject>,_ callback:@escaping ((_ err:String?,_ ret:AnyObject?)->())){
        YYNSessionManager.default()?.method("get", urlString: "resume/resumeInfo", andParams: param, andHttpHeaders: nil, success: { (ret) in
            var ret0 = ret as? [String:AnyObject]
            guard ret0 != nil, Int(truncating: ret0!["code"] as! NSNumber) == 200 else {
                callback(ret0!["msg"] as? String, nil)
                return
            }
            callback(nil, ret0!["data"] as AnyObject)
        }, failure: { (error) in
            callback(error as? String, nil)
        })
    }
}

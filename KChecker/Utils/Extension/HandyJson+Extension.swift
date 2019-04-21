//
//  HandyJson+Extension.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/4/16.
//  Copyright © 2019 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit
import HandyJSON

extension HandyJSON {
    //对象是否包含某个熟悉
    func containsProperty(_ key:String) -> Bool {
        for (name, _) in (Mirror(reflecting: self).children) {
            if name == key {
                return true
            }
        }
        return false
    }
    
    //根据key获取value
    func value(forKey key:String) -> Any? {
        
        for (name, value) in (Mirror(reflecting: self).children) {
            if name == key {
                return value
            }
        }
        return nil
    }
}

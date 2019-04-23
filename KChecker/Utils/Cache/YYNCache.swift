//
//  YYNCache.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/4/2.
//  Copyright © 2019 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit
import Cache
import SwiftyJSON
import CloudPushSDK

class YYNCache: NSObject {
    //用户相关缓存
//    static var userRelatedStorage = try? Cache<NSDictionary>(name: "UserRelated")
    
    static let userRelatedStorage = try? Storage(
        diskConfig: DiskConfig(name: "UserRelated"),
        memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10),
        transformer: TransformerFactory.forCodable(ofType: JSON.self) // Storage<User>
    )
    
    @objc static func clearCache() {
        try? self.userRelatedStorage?.removeObject(forKey: "isLogin")
        try? self.userRelatedStorage?.removeObject(forKey: "token")
        try? self.userRelatedStorage?.removeObject(forKey: "userInfo")
        CloudPushSDK.unbindAccount { (res) in
            
        }
    }
}

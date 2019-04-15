//
//  UserModel.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/3/27.
//  Copyright © 2019 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel: HandyJSON {
    var id:NSNumber!
    var name:String?
    var phone:String!
    var avatar:String?
    
    required init() {}
}

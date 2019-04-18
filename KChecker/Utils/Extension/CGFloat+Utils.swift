//
//  CGFloat+Utils.swift
//  Jobnt
//
//  Created by LiaoQiang on 2019/4/17.
//  Copyright © 2019 Yiyuan Networks 上海义援网络科技有限公司. All rights reserved.
//

import Foundation

extension CGFloat {
    
    static var MAIN_SCREEN_HEIGHT:CGFloat {
        return MyConst.MAIN_SCREEN_HEIGHT
    }
    
    static var MAIN_SCREEN_WIDTH:CGFloat {
        return MyConst.MAIN_SCREEN_WIDTH
    }
    
    static var NAV_BAR_HEIGHT:CGFloat {
        return MyConst.NAV_BAR_HEIGHT()
    }
    
    static var SYSTEEM_BOTTOM_MARGIN:CGFloat {
        return CGFloat((UIScreen.main.bounds.size.height==812 || UIScreen.main.bounds.size.height==896) ? 34:0)
    }
    
    static var TAB_BAR_HEIGHT:CGFloat {
        if (UIScreen.main.bounds.size.height==812 || UIScreen.main.bounds.size.height==896) {
            return 84;
        }
        else
        {
            return 50;
        }
    }
    
    static var EXTRA_BAR_HEIGHT:CGFloat {
        if (UIScreen.main.bounds.size.height==812 || UIScreen.main.bounds.size.height==896){
            return 12;
        }
        else
        {
            return 0;
        }
    }
}

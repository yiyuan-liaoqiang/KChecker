//
//  MyConst.swift
//  BaoLi
//
//  Created by Liao Qiang on 2018/1/9.
//  Copyright © 2018年 BaoLi. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class MyConst: NSObject {
    
    static let MAIN_SCREEN_HEIGHT       = UIScreen.main.bounds.size.height
    static let MAIN_SCREEN_WIDTH        = UIScreen.main.bounds.size.width
    static let SYSTEEM_BOTTOM_MARGIN    = CGFloat(UIScreen.main.bounds.size.height==812 ? 34:0)
    
    static func NAV_BAR_HEIGHT()->CGFloat
    {
        if UIScreen.main.bounds.size.height==812 {
            return 88;
        }
        else
        {
            return 64;
        }
    }
    
    static func TAB_BAR_HEIGHT() ->CGFloat
    {
        if UIScreen.main.bounds.size.height==812 {
            return 84;
        }
        else
        {
            return 50;
        }
    }
    
    static func EXTRA_BAR_HEIGHT()->CGFloat
    {
        if UIScreen.main.bounds.size.height == 812{
            return 12;
        }
        else
        {
            return 0;
        }
    }
    
    public static func YYSLocalizedString(_ key: String, _ comment: String) -> String {
        let languages = UserDefaults.standard.object(forKey: "NSLanguages") as! Array<String>
        let res = Bundle.init(path: Bundle.main.path(forResource: languages[0].hasPrefix("zh-Hans") ? "zh-Hans":"en", ofType: "lproj")!)?.localizedString(forKey: key, value: "", table: nil)
        return res ?? comment
    }
}



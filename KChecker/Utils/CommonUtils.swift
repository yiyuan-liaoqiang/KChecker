//
//  CommonUtils.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/24.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import UIKit

class CommonUtils: NSObject {
    
    //根据fileName获取bundle path。多语言
    class func bundlePathWithFileName(fileName:String) -> String {
        var filePath = Bundle.main.path(forResource: self.currentLanguage(), ofType: "lproj")
        if filePath == nil || !(FileManager.default.fileExists(atPath: filePath!)) {
            filePath = Bundle.main.path(forResource: fileName, ofType: nil)!
        }
        else {
            filePath = filePath! + "/" + fileName
        }
        
        return filePath!
    }
    
    class func currentLanguage() -> String {
        var language = (UserDefaults.standard.object(forKey: "NSLanguages") as! Array<String>).first!
        if language.hasPrefix("zh-Hans") {
            language = "zh-Hans"
        }
        else {
            language = "en"
        }
        return language
    }
}

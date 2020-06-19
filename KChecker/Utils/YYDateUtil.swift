//
//  YYDateUtil.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/1/29.
//  Copyright © 2019年 Liao Qiang. All rights reserved.
//

import Foundation

class YYDateUtil: NSObject {
    //timeStr to date   "yyy-MM-dd HH:mm:ss" adapt to all format
    public class func dateStringToDate(_ dateStr:String) -> Date {
        var dayStr:String?
        var timeStr:String?
        if dateStr.contains(" ") {
            dayStr = dateStr.components(separatedBy: " ").first!
            timeStr = dateStr.components(separatedBy: " ").last!
        }
        else {
            if dateStr.contains(":") {
                timeStr = dateStr
            }
            else {
                dayStr = dateStr
            }
        }
        
        var formatStyle = ""
        //day
        if dayStr != nil {
            if dayStr!.components(separatedBy: "-").count == 3 {
                formatStyle = "yyyy-MM-dd"
            }
            else if dayStr!.components(separatedBy: "-").first?.count == 4 {
                formatStyle = "yyyy-MM"
            }
            else {
                formatStyle = "MM-dd"
            }
        }
        
        if timeStr != nil {
            if timeStr!.components(separatedBy: "-").count == 3 {
                formatStyle = formatStyle + " " + "HH:mm:ss"
            }
            else {
                formatStyle = formatStyle + " " + "HH:mm"
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = formatStyle
        let date = formatter.date(from: dateStr)
        return date!
    }
}

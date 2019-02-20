//
//  UIColor+Extension.swift
//  BaoLi
//
//  Created by Liao Qiang on 2018/1/15.
//  Copyright © 2018年 BaoLi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public static func kUIColorFromRGB(hexString: String) -> UIColor{
        var cstr = hexString.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        } else {
            // Fallback on earlier versions
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
        }
    }
}

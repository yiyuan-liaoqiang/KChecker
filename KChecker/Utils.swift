//
//  Utils.swift
//  KChecker
//
//  Created by LiaoQiang on 2020/6/21.
//

import UIKit

class Utils: NSObject {

}

extension Date {
    func timeStrWithFormat(format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

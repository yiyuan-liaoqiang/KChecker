//
//  Array+Utils.swift
//  KChecker
//
//  Created by LiaoQiang on 2019/4/18.
//

import Foundation

extension Array {
    
    mutating func addObjectFromArray(_ otherArray:Array) {
        for ele in otherArray {
            self.append(ele)
        }
    }
}

//
//  Hash.swift
//  Algo
//
//  Created by hong on 5/17/25.
//

import Foundation

class Hash {

    static func hashValue(string: String) -> Int {
        
        var hashCode = 0
        
        // 与Java一致按UTF-16码元计算，非ASCII字符（如中文）也能处理
        for c in string.utf16 {
            // 普通写法
            // hashCode = hashCode * 31 + Int(c)
            // 等效写法；长字符串会超出Int范围，用&-、&+让溢出回绕而不是崩溃
            hashCode = (hashCode << 5) &- hashCode &+ Int(c)
        }
        
        return hashCode
    }
    
}

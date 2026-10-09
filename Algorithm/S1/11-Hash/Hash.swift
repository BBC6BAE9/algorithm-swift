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
        
        for i in 0..<string.count {
            let c = string[string.index(string.startIndex, offsetBy: i)]
            // 普通写法
            // hashCode = hashCode * 31 + Int(c.asciiValue!)
            // 等效写法
            hashCode = (hashCode << 5) - hashCode + Int(c.asciiValue!)
        }
        
        return hashCode
    }
    
}

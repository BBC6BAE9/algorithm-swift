//
//  Solution1.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

class Solution1 {
    // 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        
        for (i, num) in nums.enumerated() {
            if let lastIndex = dict[target - num] {
                return [lastIndex, i]
            }
            dict[num] = i
        }
        fatalError("No valid outputs")
    }
}

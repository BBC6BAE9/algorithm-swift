//
//  Solution42.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

// 42 接雨水
// https://leetcode.cn/problems/trapping-rain-water/description/

class Solution42 {
    
    // 接雨水
    func trap(_ height: [Int]) -> Int {
        var res = 0
        
        var left = 0
        var right = height.count - 1
        
        // 保存左边最高的柱子
        var maxL = height[left]
        // 保存右边最高的柱子
        var maxR = height[right]
    
        while (left < right) {
            if (maxL < maxR) {
                left += 1
                maxL = max(maxL, height[left])
                
                res += maxL - height[left]
            }else{
                right -= 1
                maxR = max(maxR, height[right])
                res += maxR - height[right]
            }
        }
        
        return res
    }
}

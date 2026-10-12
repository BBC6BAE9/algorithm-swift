//
//  MergeSortedArray.swift
//  Algorithm
//
//  Created by hong on 10/11/26.
//

import Foundation



extension Solution {
    /// https://leetcode.cn/problems/merge-sorted-array/description/
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // 边界条件判断
        var i1 = m - 1
        var i2 = n - 1
        var cur = nums1.count - 1
        
        while (i2 >= 0) {
            if (i1 >= 0 && nums2[i2] < nums1[i1]) {
                nums1[cur] = nums1[i1]
                i1 -= 1
                cur -= 1
            } else {
                nums1[cur] = nums2[i2]
                i2 -= 1
                cur -= 1
            }
        } 
    }
}
  

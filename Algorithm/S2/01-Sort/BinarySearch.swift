//
//  BinarySearch.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

class BinarySearch {
    
    /// 查找V在有序数组array中的位置
    func indexOf(array: [Int], v: Int) -> Int {
        if array.isEmpty { return -1 }
        
        var begin = 0
        var end = array.count
        
        while begin < end {
            // 使用安全的方式计算中点，避免整数溢出
            let mid = begin + (end - begin) >> 1
            
            if array[mid] == v {
                return mid
            } else if array[mid] < v {
                begin = mid + 1
            } else {
                end = mid
            }
        }
        
        return -1
    }

    
    /// 寻找v在有序数组中插入的位置（第一个大于V的元素的位置）
    func search(array: [Int], v: Int) -> Int {
        if array.isEmpty { return -1 }

        var begin = 0
        var end = array.count

        while begin < end {
            let mid = (begin + end) >> 1
            if v < array[mid] {
                end = mid
            } else {
                begin = mid + 1
            }
        }
        
        return begin
    }
}

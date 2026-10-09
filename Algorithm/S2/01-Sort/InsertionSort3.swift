//
//  InsertionSort2.swift
//  Algo
//
//  Created by hong on 6/5/25.
//

import Foundation

/// 使用【二分查找】作为优化手段进行插入查找
class InsertionSort3<E: Comparable>: Sort<E> {
    
    override func sort() {
        for begin in 1..<array.count {
            insert(source: begin, dest: search(index: begin))
        }
    }
    
    private func insert(source: Int, dest: Int) {
        let v = array[source]
        
        // 将 [insertIndex, begin) 范围内的元素往右边移动一位
        for i in stride(from: source, to: dest, by: -1) {
            array[i] = array[i - 1]
        }
        
        array[dest] = v
    }
    
    // 利用二分搜索找到 index 位置元素的插入位置
    // 已经排好序数组的区间范围是 [0, index)
    private func search(index: Int) -> Int {
        let v = array[index]
        
        var begin = 0
        var end = index

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

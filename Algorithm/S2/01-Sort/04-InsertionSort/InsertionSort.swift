//
//  InsertionSort.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

/// 💡：插入排序类似扑克牌的排序。

/// 执行流程
/// 1、在执行过程中，插入排序会将序列分为2部分
///  - 头部是拍好序的，尾部是待排序的
/// 2、从头开始扫描每一个元素
///  - 从头扫描到每一个元素，就将它插入到头部合适的位置，是的头部数据依然保持有序
class InsertionSort1<E: Comparable>: Sort<E> {
    
    override func sort() {
        for begin in 1..<array.count { // 从头开始抓牌
            var cur = begin
            while cur > 0 && cmp(i1: cur, i2: cur - 1) < 0 {
                swap(i1: cur, i2: cur - 1)
                cur -= 1
            }
        }
    }
}

/// 插入排序的优化算法
class InsertionSort2<E:Comparable>: Sort<E> {
    
    override func sort() {
        for begin in 1..<array.count {
            var cur = begin
            let v = array[cur]
            while cur > 0 && cmpElements(v1: v, v2: array[cur - 1]) < 0 {
                array[cur] = array[cur - 1]
                cur -= 1
            }
            array[cur] = v
        }
    }
}

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

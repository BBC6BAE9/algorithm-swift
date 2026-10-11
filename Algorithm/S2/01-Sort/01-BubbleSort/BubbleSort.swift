//
//  BubbleSort.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

/// 💡每一轮都把最大的弄到最右边，排除最右边的这个，再从头来一遍
func bubbleSort(array: inout [Int]){
    for end in stride(from: array.count - 1, to: 0, by: -1) {
        for begin in 1...end {
            if array[begin] < array[begin - 1] {
                let tmp = array[begin]
                array[begin] = array[begin - 1]
                array[begin - 1] = tmp
            }
        }
    }
}

/// 💡每一轮都把最大的弄到最右边，排除最右边的这个，再从头来一遍
class BubbleSort<E: Comparable>: Sort<E> {
    override func sort() {
        for end in stride(from: array.count - 1, to: 0, by: -1) {
            for begin in 1...end {
                if cmp(i1: begin, i2:begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                }
            }
        }
    }
    
}
/// 💡如果序列已经完全有序，下轮提前终止冒泡排序
class BubbleSort2<E: Comparable>: Sort<E> {
    override func sort() {
        for end in (1..<array.count).reversed() {
            var sorted = true
            for begin in 1...end {
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                    sorted = false
                }
            }
            if sorted { break }
        }
    }
}

/// 💡 记录最后一次交换的下标 sortedIndex，直接缩小下一轮的范围。
class BubbleSort3<E: Comparable>: Sort<E> {
    
    override func sort() {
        var end = array.count - 1 // 初始化终点位置为最后一个索引
        while end >= 1 {
            var sortedIndex = 0
            for begin in 1...end {
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                    
                    sortedIndex = begin
                }
            }
            end = sortedIndex
        }
    }
}


/// 排序算法的稳定性：相等的两个元素，在排序前后的相对位置保持不变，那么这是稳定的排序算法，冒泡算法就是稳定的排序算法
/// 原地算法（in-place Algorithm），不依赖额外的资源或者依赖少数的资源，仅依靠输出来覆盖输入。冒泡算法就是in-place算法


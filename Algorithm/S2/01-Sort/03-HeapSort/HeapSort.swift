//
//  HeapSort.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

/// 堆排序是对选择排序的一种优化
/// 堆能让你快速找到当前的最大值或最小值。 HeapSort 用的是“大顶堆”。

/// 💡
///  1、对序列进行原地建堆（heapify）
///  2、重复执行以下操作，知道堆的数量元素为1
///     - 交换堆顶的元素与尾元素
///     - 堆的数量减1
///     - 对0位置进行一次siftdown的操作

// TODO: Heap需要复习
class HeapSort<E: Comparable>: Sort<E> {
    
    private var heapSize: Int = 0
    
    override func sort() {
        heapSize = array.count
        
        // 原地建堆
        for i in (0 ..< (heapSize >> 1)).reversed() {
            siftDown(index: i)
        }
        
        while heapSize > 1 {
            // 交换堆顶元素和尾部元素
            swap(i1: 0, i2: heapSize - 1)
            
            heapSize -= 1
            
            // 对0位置进行siftDown（恢复堆的性质）
            siftDown(index: 0)
        }
    }
    
    private func siftDown(index: Int) {
        var index = index
        let element = array[index]
        let half = heapSize >> 1
        // 第一个的索引 == 非叶子节点的数量
        // indx < 第一个叶子节点的索引
        // 必须保证index的位置是非叶子节点
        while index < half { // 没有子节点
            // index的情况有两种
            // 1、只有左子节点
            // 2、既有左子节点又有右子节点
            
            // 默认使用左子节点跟它进行比较
            var childIndex = (index << 1) + 1
            var child = array[childIndex]
            
            // 右子节点
            let rightIndex = childIndex + 1
            
            // 选出左右子节点最大的那个
            if rightIndex < heapSize && cmpElements(v1: array[rightIndex], v2: child) > 0 {
                childIndex = rightIndex
                child = array[childIndex]
            }
            
            if cmpElements(v1: element, v2: child) > 0 { break }
            
            // 将子节点存放到index的位置
            array[index] = child
            
            // 重新设置index
            index = childIndex
        }
        
        array[index] = element
    }
}

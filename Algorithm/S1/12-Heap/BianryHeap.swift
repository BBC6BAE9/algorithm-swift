//
//  BianryHeap.swift
//  Algo
//
//  Created by hong on 5/28/25.
//

import Foundation

// 默认是最大堆
class BinaryHeap<E: Comparable>: AbstractHeap<E> {
    
    typealias E = E
    
    private var elements: FixedSizeArray<E>
    
    private var size = 0

    init(elements:[E]) {
        
        guard elements.count > 0 else {
            self.elements = FixedSizeArray.init(capacity: DEFAULT_CAPACITY)
            super.init()
            return
        }
        
        size = elements.count
        let capacity = max(DEFAULT_CAPACITY, elements.count)
        self.elements = FixedSizeArray<E>(capacity: capacity)
        for i in 0..<elements.count {
            self.elements[i] = elements[i]
        }
        super.init()
        heapify()
        
    }

    override init() {
        self.elements = FixedSizeArray.init(capacity: DEFAULT_CAPACITY)
        super.init()
    }
    
    // 清空
    override func clear() {
        for i in 0..<size {
            elements[i] = nil
        }
        size = 0
    }
    
    // 添加元素
    // element 不允许为空
    override func add(element: E) {
        // 扩容
        ensureCapacity(capacity: size + 1)
        
        elements[size] = element
        
        size += 1
        
        siftUp(index: size - 1)
    }
    
    // 上滤
    private func siftUp(index: Int) {
        /*
        var index = index
        let e = elements[index]!
        // index > 0 有父节点
        while index > 0 {
            let parent = (index - 1) >> 1;
            let p = elements[parent]!
            if e < p { return }
            
            // 交换
            let tmp = elements[index]
            elements[index] = elements[parent]
            elements[parent] = tmp
            index = pindex
        }
         */
        
        var index = index
        
        let e = elements[index]!
        
        while index > 0 {
            let parent = (index - 1) >> 1;
            let p = elements[parent]!
            if e < p { break }
            elements[index] = p
            index = parent
        }
        elements[index] = e
    }
    
    // 获取堆顶元素
    override func get() -> E {
        emptyCheck()
        return elements[0]!
    }
    
    // 删除堆顶元素
    override func remove() -> E {
        emptyCheck()
        
        size -= 1
        let lastIndex = size
        
        let root = elements[0]!
        
        elements[0] = elements[lastIndex]
        elements[lastIndex] = nil
        
        siftDown(index: 0)
        return root
    }
    
    private func siftDown(index: Int) {
        var index = index
        let element  = elements[index]!
        let half = size >> 1
        // 第一个的索引 == 非叶子节点的数量
        // indx < 第一个叶子节点的索引
        // 必须保证index的位置是非叶子节点
        while index < half { // 没有子节点
            // index的情况有两种
            // 1、只有左子节点
            // 2、既有左子节点又有右子节点
            
            // 默认使用左子节点跟它进行比较
            var childIndex = (index << 1) + 1
            var child = elements[childIndex]!
            
            // 右子节点
            let rightIndex = childIndex + 1
            
            // 选出左右子节点最大的那个
            if rightIndex < size && elements[rightIndex]! > child {
                childIndex = rightIndex
                child = elements[childIndex]!
            }
            
            
            if element >= child { break }
            
            // 将子节点存放到index的位置
            elements[index] = child
            
            // 重新设置index
            index = childIndex
            
        }
        
        elements[index] = element
    }
    
    // 删除堆顶元素的同时插入一个新元素
    override func replace(element: E) -> E? {
        // 方法一
        // let root = remove()
        // add(element: element)
        // return root
        var root: E?
        // 方法二（性能更好）
        if size == 0 {
            elements[0] = element
            size = 1
        } else {
            root = elements[0]
            elements[0] = element
            siftDown(index: 0)
        }
        return root
    }
    
    private func emptyCheck() {
        if (size == 0) {
            fatalError("Heap is empty")
        }
    }
    
    /// 动态扩容
    func ensureCapacity(capacity: Int) {
        let oldCapacity = elements.length
        if oldCapacity > capacity {
            return
        }
        // 扩容1.5倍
        // 位运算，右移一位，相当于除以2
        // 扩容倍数和所容倍数的乘积如果是1，会出现复杂度震荡，避开即可
        let newCapacity = oldCapacity + (oldCapacity >> 1)
        let newElements = FixedSizeArray<E>(capacity: newCapacity)
        
        for i in 0..<size {
            newElements[i] = elements[i]
        }
        self.elements = newElements
        
        print("old capacity = \(oldCapacity), new capacity = \(newCapacity)")
    }
    
    /// 批量建堆
    private func heapify() {
        // 方法一：自上而下的上溢
//        for i in (1..<size) {
//            siftUp(index: i)
//        }
            
        // 方法二：自下而上的下溢
        for i in (0..<(size >> 1)).reversed() {
            siftDown(index: i)
        }
    }
}

class Solution {
    func topK() {
        
    }
}

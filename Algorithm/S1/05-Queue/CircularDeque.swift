//
//  CircularDeque.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

/// 循环双端队列
class CircularDeque<E: Equatable> {
    
//    private var _front: Int = 0
//
//    private var _size: Int = 0
//
//    var elements: FixedSizeArray<E> = .init(capacity: DEFAULT_CAPACITY)
//
//    // 元素的数量
//    func size() -> Int {
//        return 0
//    }
//    
//    // 是否为空
//    func isEmpty() -> Bool {
//        return false
//    }
//    
//    // 尾部入队
//    func enQueueRear(element: E) {
//        ensureCapacity(capacity: _size + 1)
//        elements[index(_size)] = element
//        _size += 1
//    }
//    
//    // 尾部出队
//    func deQueueRear() -> E? {
//        let rearIndex = index(_size - 1)
//        let rearElement = elements[rearIndex]
//        elements[rearIndex] = nil
//        return rearElement
//    }
//    
//    // 头部入队
//    func enQueueFront(element: E) {
//        ensureCapacity(capacity: _size + 1)
//        let front = index(-1)
//        elements[front] = element
//        _size += 1
//    }
//    
//    // 头部出队
//    func deQueueFront() -> E? {
//        let frontElement = elements[_front]
//        elements[_front] = nil
//        _front = index(1)
//        _size -= 1
//        return frontElement
//    }
//    
//    /// 队头元素
//    func front() -> E? {
//        return elements[_front]
//    }
//    
//    /// 队尾元素
//    func rear() -> E? {
//        return elements[index(_size - 1)]
//    }
//    
//    private func index(_ index: Int) -> Int {
//        let index =  index + _front
//        if (index < 0) {
//            return index + elements.length
//        }
//        return index % elements.size()
//    }
//    
//    /// 动态扩容
//    private func ensureCapacity(capacity: Int) {
//        let oldCapacity = elements.size()
//        if oldCapacity > capacity {
//            return
//        }
//        // 扩容1.5倍
//        // 位运算，右移一位，相当于除以2
//        // 扩容倍数和所容倍数的乘积如果是1，会出现复杂度震荡，避开即可
//        let newCapacity = oldCapacity + (oldCapacity >> 1)
//        let newElements: FixedSizeArray<E> = .init(capacity: newCapacity)
//        
//        for i in 0..<_size {
//            newElements[i] = elements[index(i)]
//        }
//        self.elements = newElements
//        
//        _front = 0
//    }
}

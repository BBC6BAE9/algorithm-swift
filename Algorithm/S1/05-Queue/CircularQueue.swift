//
//  CircleQueue.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

class CircularQueue<E> {
    
    private var _front = 0
    private var _size: Int
    
    var elements: FixedSizeArray<E>
    
    init(){
        _size = 0
        self.elements = .init(capacity: DEFAULT_CAPACITY)
    }
    
    func size() -> Int {
        return _size
    }
    
    func isEmpty() -> Bool {
        return _size == 0
    }
    
    // 入队
    func enQueue(_ element: E) {
        ensureCapacity(capacity: _size + 1)
        elements[index(_size)] = element
        _size += 1
    }
    
    // 出队
    func deQueue() -> E {
        let frontElement = elements[_front]
        elements[_front] = nil
        _front = index(1)
        _size -= 1
        return frontElement!
    }
    
    func front() -> E{
        return elements[_front]!
    }
    
    /// 动态扩容
    private func ensureCapacity(capacity: Int) {
        let oldCapacity = elements.size()
        if oldCapacity > capacity {
            return
        }
        // 扩容1.5倍
        // 位运算，右移一位，相当于除以2
        // 扩容倍数和所容倍数的乘积如果是1，会出现复杂度震荡，避开即可
        let newCapacity = oldCapacity + (oldCapacity >> 1)
        let newElements: FixedSizeArray<E> = .init(capacity: newCapacity)
        
        for i in 0..<_size {
            newElements[i] = elements[index(i)]
        }
        self.elements = newElements
        
        _front = 0
    }
    
    
    private func index(_ index: Int) -> Int {
        return (index + _front) % elements.size()
    }
}

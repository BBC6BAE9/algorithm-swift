//
//  ArrayList.swift
//  Algo
//
//  Created by hong on 2/23/25.
//

import Foundation

/// 动态数组
/// 很多语言的数组是固定容量的，我们需要有一个能够动态扩容的数据结构，这个数据结构就是动态数组
class ArrayList<E: Equatable> {
    
    /// 元素的数量
    var _size: Int = 0
    
    /// 所有的元素
    private var elements: [E?]
    
    /// 构造方法
    /// - Parameter capacity: 容量
    init(capacity: Int = DEFAULT_CAPACITY) {
        let capacity = (capacity < DEFAULT_CAPACITY) ? DEFAULT_CAPACITY : capacity
        self.elements = [E?](repeating: nil, count: capacity)
    }
    
    /// 动态扩容
    func ensureCapacity(capacity: Int) {
        let oldCapacity = elements.count
        if oldCapacity > capacity {
            return
        }
        // 扩容1.5倍
        // 位运算，右移一位，相当于除以2
        // 扩容倍数和所容倍数的乘积如果是1，会出现复杂度震荡，避开即可
        let newCapacity = oldCapacity + (oldCapacity >> 1)
        var newElements = [E?](repeating: nil, count: newCapacity)
        
        for i in 0..<_size {
            newElements[i] = elements[i]
        }
        self.elements = newElements
        
        print("old capacity = \(oldCapacity), new capacity = \(newCapacity)")
    }
    
    /// 缩容
    // TODO: 缩容量的这个函数可能有Bug，需要完善测试用例来检查
    private func trim() {
        let capacity = elements.count
        let newCapacity = capacity >> 1;
        if (_size >= (newCapacity) && capacity > DEFAULT_CAPACITY ) { return }
        
        print("trim: size = \(_size), old capacity = \(capacity), new capacity = \(newCapacity)")

        var newElements = [E?](repeating: nil, count: newCapacity)
        for i in 0..<_size {
            newElements[i] = elements[i]
        }
        self.elements = newElements
    }
}

// ArrayList实现线性表协议
extension ArrayList: List {
    
    func add(index: Int, element: E) {
        
        rangeCheckForAdd(index: index)
        
        ensureCapacity(capacity: _size + 1)
        
        for i in (index..<_size).reversed() {
            elements[i+1] = elements[i]
        }
        
        elements[index] = element
        
        _size += 1
    }
    
    /// 清除所有元素
    func clear() {
        for i in 0..<_size {
            elements[i] = nil
        }
        _size = 0
    }
    
    /// 获取index位置的元素
    func get(index: Int) -> E? {
        
        rangeCheck(index: index)
        
        return elements[index]
    }
    
    func set(index: Int, element: E) -> E? {
        rangeCheck(index: index)
        
        let old = elements[index]
        elements[index] = element
        return old
    }
    
    func remove(index: Int) -> E? {
        rangeCheck(index: index)
        
        let old = elements[index]
        for i in index..<_size-1 {
            elements[i] = elements[i+1]
        }
        _size -= 1
        elements[_size] = nil
        
        trim()
        
        return old
    }
    
    func indexOf(element: E) -> Int {
        for i in 0..<_size {
            if (elements[i] == element) {
                return i
            }
        }
        return ELEMENT_NOT_FOUND
    }
    
}

// ArrayList的进一步优化
// 在数组的前面插入或删除，需要大量的转移元素
// 使用一个int first存储首元素的位置

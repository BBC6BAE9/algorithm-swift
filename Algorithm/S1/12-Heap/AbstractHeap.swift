//
//  AbstractHeap.swift
//  Algo
//
//  Created by hong on 5/28/25.
//

import Foundation

class AbstractHeap<E: Comparable>: Heap {
    
    func clear() {
        fatalError()
    }
    
    func add(element: E) {
        fatalError()
    }
    
    func get() -> E {
        fatalError()
    }
    
    func remove() -> E {
        fatalError()
    }
    
    func replace(element: E) -> E? {
        fatalError()
    }
    
    // 子类直接维护这个计数，getSize()/isEmpty()才能反映真实的元素数量
    var size = 0
    
    func getSize() -> Int {
        return size
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
}

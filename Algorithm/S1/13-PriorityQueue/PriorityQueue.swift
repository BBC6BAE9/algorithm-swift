//
//  PriorityQueue.swift
//  Algo
//
//  Created by hong on 5/29/25.
//

import Foundation

class PriorityQueue<E: Comparable> {
    
    private var heap: BinaryHeap<E> = .init()
    
    // 元素的数量
    func getSize() -> Int {
        return heap.getSize()
    }
    
    // 是否为空
    func isEmpty() -> Bool {
        return heap.isEmpty()
    }
    
    // 入队
    func enQueue(element: E) {
        heap.add(element: element)
    }
    
    // 出队
    func deQueue() -> E? {
        return heap.remove()
    }
    
    /// 获取队头元素
    func front() -> E? {
        return heap.get()
    }
}
    

class Person {
    // 名称
    var name: String
    // 断掉的骨头的数量，断掉的骨头越多，优先级越高
    var boneBreak: Int
    
    init(name: String, boneBreak: Int) {
        self.name = name
        self.boneBreak = boneBreak
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.boneBreak < rhs.boneBreak
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

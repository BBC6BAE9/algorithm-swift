//
//  Deque.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

// 双端队列
// 双端队列是能在头尾两端添加、删除的队列

// 可以使用动态数组和链表来进行实现，因为队列主要是往头尾操作元素，我们选择双向链表
/// Qeque: Double Ended queue
class Deque<E: Equatable> {
    
    let list: DoubleLinkedList<E> = .init()
    
    // 元素的数量
    func size() -> Int {
        return list.size()
    }
    
    // 是否为空
    func isEmpty() -> Bool {
        return list.isEmpty()
    }
    
    // 入队
    func enQueueRear(element: E) {
        list.add(element: element)
    }
    
    // 出队
    func deQueueRear() -> E? {
        return list.remove(index: list.size() - 1)
    }
    
    
    // 入队
    func enQueueFront(element: E) {
        list.add(index: 0, element: element)
    }
    
    // 出队
    func deQueueFront() -> E? {
        return list.remove(index: 0)
    }
    
    
    /// 获取队头元素
    func front() -> E? {
        list.get(index: 0)
    }
}
 

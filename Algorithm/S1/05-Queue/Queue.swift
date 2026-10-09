//
//  Queue.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

// 队列
// 队列是一种特殊的线性表，只能在头尾两端进行操作
// rear（队尾）：只能从队尾添加元素，一般叫做enQueue，入队
// front（队头）：只能从队头移除元素，一般叫做deQueue，出队

// 可以使用动态数组和链表来进行实现，因为队列主要是往头尾操作元素，我们选择双向链表
class Queue<E: Equatable> {
    
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
    func enQueue(element: E) {
        list.add(element: element)
    }
    
    // 出队
    func deQueue() -> E? {
        list.remove(index: 0)
    }
    
    
    /// 获取队头元素
    func front() -> E? {
        list.get(index: 0)
    }
}
 

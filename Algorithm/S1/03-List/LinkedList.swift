//
//  LinkedList.swift
//  Algo
//
//  Created by hong on 2/23/25.
//

import Foundation

/// 链表
/// 动态数组有一个明显的缺点，就是可能会造成内存空间的大量浪费，能否用到多少内存就使用多少内存？链表就可以用到这一点，链表是一种链式存储的线性表，所有的内存地址不一定是连续的
class LinkedList<E: Equatable> {
    
    var _size: Int = 0

    var first: Node<E>?
    
    /// 获取index位置对应的节点对象
    private func node(index: Int) -> Node<E>? {
        
        rangeCheckForAdd(index: index)
        
        var node: Node<E>? = self.first
        
        for _ in 0..<index {
            node = node?.next
        }
        
        return node
        
    }
    
    /// 节点
    class Node<T> {
        var element: T
        var next: Node<T>?
        
        init(element: T, next: Node<T>?) {
            self.element = element
            self.next = next
        }
        
        deinit {
            print("node \(element) 被释放")
        }
    }
    
}

extension LinkedList: List {
    
    func clear() {
        _size = 0
        self.first = nil
    }
    
    func get(index: Int) -> E? {
        return node(index: index)?.element
    }
    
    func set(index: Int, element: E) -> E? {
        let node = node(index: index)
        let old = node?.element
        node?.element = element
        return old
    }
    
    func remove(index: Int) -> E? {
        rangeCheck(index: index)
        
        var tmpnode = first
        if index == 0 {
            first = first?.next
        } else {
            let prev = node(index: index - 1)
            tmpnode = prev?.next
            prev?.next = tmpnode?.next
        }
        
        _size -= 1
        return tmpnode?.element
    }
    
    func add(index: Int, element: E) {
        rangeCheckForAdd(index: index)
        
        if index == 0 {
            self.first = Node(element: element, next: first)
        } else {
            let prev = node(index: index - 1)
            prev?.next = Node(element: element, next: prev?.next)
        }
        
        _size += 1
    }
    
    func indexOf(element: E) -> Int {
        var node = first
        for i in 0..<_size {
            if element == node?.element {
                return i
            }
            node = node?.next
        }
        return ELEMENT_NOT_FOUND
    }

}

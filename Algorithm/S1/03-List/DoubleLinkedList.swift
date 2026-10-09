//
//  DoubleLinkedList.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

/// 双向链表
/// 使用双向链表可以提升链表的综合性能
class DoubleLinkedList<E: Equatable> {
    
    var _size: Int = 0

    private var first: Node<E>?
    
    private var last: Node<E>?
    
    /// 获取index位置对应的节点对象
    private func node(index: Int) -> Node<E>? {
        
        rangeCheckForAdd(index: index)
        
        if index < _size >> 1 {
            var node: Node<E>? = self.first
            for _ in 0..<index {
                node = node?.next
            }
            return node
        } else {
            var node: Node<E>? = self.last
            for _ in (index..<(_size - 1)).reversed() {
                node = node?.prev
            }
            return node
        }
    }
    
    /// 节点
    class Node<T> {
        var element: T
        var next: Node<T>?
        var prev: Node<T>?

        init(prev: Node<T>?, element: T, next: Node<T>?) {
            self.element = element
            self.prev = prev
            self.next = next
        }
        
        deinit {
            print("node \(element) 被释放")
        }
    }
    
}

extension DoubleLinkedList: List {
    
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
        
        let node = node(index: index)
        let prev = node?.prev
        let next = node?.next

        if (prev == nil) {
            first = next
        }else{
            prev?.next = next
        }
        
        if (next == nil) {
            last = prev
        }else{
            next?.prev = prev
        }
    
        _size -= 1
        return node?.element
    }
    
    func add(index: Int, element: E) {
        rangeCheckForAdd(index: index)
        
        if index == _size {
            
            let oldLast = last
            last = Node(prev: oldLast, element: element, next: nil)
            
            if oldLast == nil {
                first = last
            }else{
                oldLast?.next = last
            }
        }else{
            let next = node(index: index)
            let prev = next?.prev
            
            let node = Node(prev: prev, element: element, next: next)
            
            next?.prev = node
            
            if (prev == nil) {
                first = node
            }else{
                prev?.next = node
            }
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

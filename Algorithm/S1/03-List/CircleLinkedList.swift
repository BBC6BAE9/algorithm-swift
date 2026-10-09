//
//  CircleLinkedList.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

// 单向循环链表
class CircleLinkedList<E: Equatable> {
    
    var _size: Int = 0

    private var first: Node<E>?
    
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

extension CircleLinkedList: List {
    
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
    
    // TODO: 需要修改
    func remove(index: Int) -> E? {
        rangeCheck(index: index)
        
        var tmpnode = first
        if index == 0 {
            if (_size == 1) {
                first = nil
            }else{
                let last = node(index: _size - 1)
                first = first?.next
                last?.next = first
            }
        } else {
            let prev = node(index: index - 1)
            tmpnode = prev?.next
            prev?.next = tmpnode?.next
        }
        
        _size -= 1
        return tmpnode?.element
    }
    
    // TODO: 需要修改
    func add(index: Int, element: E) {
        rangeCheckForAdd(index: index)
        
        if index == 0 {
            let newFirst = Node(element: element, next: first)
            let last = (_size == 0) ? newFirst : node(index: _size - 1)
            last?.next = newFirst
            first = newFirst
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

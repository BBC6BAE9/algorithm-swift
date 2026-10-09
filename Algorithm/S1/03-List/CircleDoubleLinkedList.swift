//
//  CircleDoubleLinkedList.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

/// 双向循环链表
class CircleDoubleLinkedList<E: Equatable> {
    
    var _size: Int = 0

    private var first: Node<E>?
    
    private var last: Node<E>?
    
    ///【约瑟夫问题】【成员变量】current指针，指向某个节点
    var current: Node<E>?
    
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
            // print("node \(element) 被释放")
        }
    }
    
}

extension CircleDoubleLinkedList: List {
    
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
        return remove(node: node(index: index))
    }
    
    func add(index: Int, element: E) {
        rangeCheckForAdd(index: index)
        
        if index == _size {
            let oldLast = last
            last = Node(prev: oldLast, element: element, next: first)
            
            if oldLast == nil {
                first = last
                first?.next = first
                first?.prev = first
            }else{
                oldLast?.next = last
                first?.prev = last  
            }
        }else{
            let next = node(index: index)
            let prev = next?.prev
            let node = Node(prev: prev, element: element, next: next)
            next?.prev = node
            prev?.next = node
            
            if (index == 0) {
                first = node
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

    private func remove(node: Node<E>?) -> E? {
        if _size == 1 {
            first = nil
            last = nil
        }else{
            let prev = node?.prev
            let next = node?.next
            prev?.next = next
            next?.prev = prev
            
            if (node === first) {
                first = next
            }
            
            if (node === last) {
                last = prev
            }
        }
        
        _size -= 1
        return node?.element
    }
}

extension CircleDoubleLinkedList {

    /// 【约瑟夫问题】【函数】 reset() 让current指向头节点first
    func reset() {
        current = first
    }

    /// 【约瑟夫问题】【函数】next() 让current往后走一步，也就是current = current.next
    func next() -> E? {
        if current == nil { return nil }
        current = current?.next
        return current?.element
    }

    /// 【约瑟夫问题】【函数】remove() 删除current指向的节点，删除成功后让current指向下一个节点
    func remove() -> E? {
        if current == nil { return nil }
        
        let next = current?.next;
        let element = remove(node: current)
        
        if _size == 0 {
            current = nil
        }else{
            current = next
        }
        
        return element
    }
    
}


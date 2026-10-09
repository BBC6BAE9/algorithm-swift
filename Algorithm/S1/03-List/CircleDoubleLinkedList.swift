//
//  CircleDoubleLinkedList.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

/// 双向循环链表
class CircleDoubleLinkedList<E: Equatable> {
    
    private(set) var _size: Int = 0

    private var first: Node<E>?
    
    private var last: Node<E>?
    
    ///【约瑟夫问题】【成员变量】current指针，指向某个节点
    private(set) var current: Node<E>?
    
    /// 获取index位置对应的节点对象
    private func node(index: Int) -> Node<E>? {
        
        rangeCheck(index: index)
        
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
        fileprivate(set) var element: T
        fileprivate(set) var next: Node<T>?
        fileprivate(set) var prev: Node<T>?

        init(prev: Node<T>?, element: T, next: Node<T>?) {
            self.element = element
            self.prev = prev
            self.next = next
        }
        
        deinit {
            // print("node \(element) 被释放")
        }
    }

    deinit {
        clear()
    }
    
}

extension CircleDoubleLinkedList: List {
    
    func clear() {
        // 循环结构中的引用不会自动释放，逐个断开前后连接。
        var node = first
        for _ in 0..<_size {
            let next = node?.next
            node?.next = nil
            node?.prev = nil
            node = next
        }

        _size = 0
        first = nil
        last = nil
        current = nil
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
        guard let node, _size > 0 else { return nil }

        let next = node.next
        if _size == 1 {
            first = nil
            last = nil
        }else{
            let prev = node.prev
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
        // 按索引删除当前节点时，也需要把游标移到后继节点。
        if node === current {
            current = _size == 0 ? nil : next
        }

        node.next = nil
        node.prev = nil
        return node.element
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
        return remove(node: current)
    }
    
}

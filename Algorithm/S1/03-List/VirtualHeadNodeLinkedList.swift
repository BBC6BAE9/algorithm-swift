//
//  VirtualHeadNodeLinkedList.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

/// 链表（虚拟头节点）
/// 有的时候为了让代码更加精简，统一所有节点的处理逻辑，可以在最前面增加一个虚拟的头节点（不存储数据）
class VirtualHeadNodeLinkedList<E: Equatable> {
    
    var _size: Int = 0

    private var first: Node<E?>?
    
    init() {
        first = Node(element: nil, next: nil)
    }
    
    /// 获取index位置对应的节点对象
    private func node(index: Int) -> Node<E?>? {
        
        rangeCheckForAdd(index: index)
        
        var node: Node<E?>? = self.first?.next
        
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

extension VirtualHeadNodeLinkedList: List {
    
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
        
        let prev = (index == 0) ? first : node(index: index - 1)
        let tmpnode = prev?.next
        prev?.next = tmpnode?.next
        
        _size -= 1
        return tmpnode?.element
    }
    
    func add(index: Int, element: E) {
        rangeCheckForAdd(index: index)
        
        let prev = (index == 0) ? self.first : node(index: index - 1)
        prev?.next = Node(element: element, next: prev?.next)
        
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

//
//  ListSet.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation

/// 基于链表的集合
class ListSet<T: Equatable>: SetProtocol {
    
    private var list = LinkedList<T>()
    
    typealias E = T
    
    func contains(element: T) -> Bool {
        return list.contains(element: element)
    }
    
    func add(element: T) {
//        if list.contains(element: element) { return }
//        list.add(element: element)
        
        // 覆盖
        let index = list.indexOf(element: element)
        if index != ELEMENT_NOT_FOUND {
            _ = list.set(index: index, element: element)
        }else{
            list.add(element: element)
        }
    }
    
    func remove(element: T) {
        // 覆盖
        let index = list.indexOf(element: element)
        if index != ELEMENT_NOT_FOUND {
            _ = list.remove(index: index)
        }
    }
    
    func size() -> Int {
        list.size()
    }
    
    func isEmpty() -> Bool {
        list.isEmpty()
    }
    
    func clear() {
        list.clear()
    }
    
}

extension ListSet: Sequence {
    
    func makeIterator() -> AnyIterator<T> {
        var current = list.first
        return AnyIterator {
            let element = current?.element
            current = current?.next
            return element
        }
    }
}

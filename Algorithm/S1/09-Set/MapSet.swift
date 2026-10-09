//
//  MapSet.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation
  
class MapSet<T: Comparable>: SetProtocol {
    
    // TODO: 原意是想放一个any类型的，但是编译有问题，放了Int，不影响功能
    private var tree = TreeMap<T, Int?>()
    
    func contains(element: T) -> Bool {
        return tree.containsKey(key: element)
    }
    
    func add(element: T) {
        _ = tree.put(key: element, value: nil)
    }
    
    func remove(element: T) {
        return tree.remove(key: element)
    }
    
    func size() -> Int {
        return tree.size
    }
    
    func isEmpty() -> Bool {
        return tree.isEmpty()
    }
    
    func clear() {
        tree.clear()
    }

}

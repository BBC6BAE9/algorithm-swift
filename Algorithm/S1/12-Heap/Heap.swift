//
//  Heap.swift
//  Algo
//
//  Created by hong on 5/24/25.
//

import Foundation

protocol Heap {
    
    associatedtype E: Comparable
    
    // 元素的数量
    func getSize() -> Int
    
    // 是否为空
    func isEmpty() -> Bool
    
    // 清空
    func clear()
    
    // 添加元素
    func add(element: E)
    
    // 获取堆顶元素
    func get() -> E
    
    // 删除堆顶元素
    func remove() -> E
    
    // 删除堆顶元素的同时插入一个新元素
    func replace(element: E) -> E?
    
}

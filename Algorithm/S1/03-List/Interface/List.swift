//
//  List.swift
//  Algo
//
//  Created by hong on 2/23/25.
//

import Foundation

/// 默认容量
let DEFAULT_CAPACITY: Int =  10

/// 元素没找到
let ELEMENT_NOT_FOUND: Int =  -1

/// List协议(java里面叫接口)
protocol List {
    
    associatedtype E
    
    /// 元素的数量
    var _size: Int { get set }
    
    /// 清除所有元素
    func clear()
    
    /// 元素的数量
    func size() -> Int
    
    /// 是否为空
    func isEmpty() -> Bool
    
    /// 是否包含某个元素
    func contains(element: E) -> Bool
    
    /// 添加一个元素
    func add(element: E)
    
    /// 获取index位置的元素
    func get(index: Int) -> E?
    
    /// 设置index位置的元素
    /// - Parameters:
    /// - Returns: 原来的元素
    func set(index: Int, element: E) -> E?
    
    /// 在index位置的添加一个元素
    func add(index: Int, element: E)
    
    /// 删除index位置的元素
    func remove(index: Int) -> E?
    
    /// 查看元素的索引
    func indexOf(element: E) -> Int
    
}

// 线性表的公共实现
extension List {
    
    /// 元素的数量
    func size() -> Int {
        return _size
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return _size == 0
    }
    
    /// 是否包含某个元素
    func contains(element: E) -> Bool {
        return self.indexOf(element: element) != ELEMENT_NOT_FOUND
    }
    
    /// 添加一个元素
    func add(element: E) {
        self.add(index: _size, element: element)
    }
    
    /// 越界检查
    func rangeCheck(index: Int) {
        if (index < 0 || index >= _size) {
            fatalError("Index out of bounds")
        }
    }
    
    /// add相关方法的越界检查
    internal func rangeCheckForAdd(index: Int) {
        if (index < 0 || index > _size) {
            fatalError("Index out of bounds")
        }
    }
    
    /// 抛出越界错误
    internal func outOFBounds() {
        fatalError("Index out of bounds")
    }
    
}

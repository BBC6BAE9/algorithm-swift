//
//  Stack.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

/// 栈是一种特殊的线性表，只能在一端进行操作
/// push 入栈
/// pop 出栈
/// LIFO：last in first out
/// 栈的内部实现可以直接利用以前学过的数据结构
/// 动态数组、链表都可以，两者操作最后一个元素，复杂度都是o(1)级别的，用哪个都可以
class Stack<E: Equatable> {
    
    private var list: ArrayList<E> = .init()
    
     func size() -> Int {
         return list.size()
    }
    
    func push(element: E) {
        list.add(element: element)
    }
    
    func pop() -> E? {
        return list.remove(index: (list.size() - 1))
    }
    
    func top() -> E? {
        if list.size() == 0 {
            return nil
        }
        return list.get(index: list.size() - 1)
    }
    
    func isEmpty() -> Bool {
        return size() == 0
    }
}

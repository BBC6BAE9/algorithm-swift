//
//  InsertionSort1.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

/// 插入排序的优化算法
class InsertionSort2<E:Comparable>: Sort<E> {
    
    override func sort() {
        for begin in 1..<array.count {
            var cur = begin
            let v = array[cur]
            while cur > 0 && cmpElements(v1: v, v2: array[cur - 1]) < 0 {
                array[cur] = array[cur - 1]
                cur -= 1
            }
            array[cur] = v
        }
    }
}

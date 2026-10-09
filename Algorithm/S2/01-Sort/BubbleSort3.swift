//
//  BubbleSort3.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

class BubbleSort3<E: Comparable>: Sort<E> {
    
    override func sort() {
        var end = array.count - 1 // 初始化终点位置为最后一个索引
        
        while end >= 1 {
            var sortedIndex = 0
            for begin in 1...end {
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                    
                    sortedIndex = begin
                }
            }
            end = sortedIndex
        }
    }
    
}

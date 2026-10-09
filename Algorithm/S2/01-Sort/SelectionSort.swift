//
//  SelectionSort.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

/// 选择排序
class SelectionSort<E:Comparable>: Sort<E> {
    
    override func sort() {
        for end in (1..<array.count).reversed() {
            var maxIndex = 0
            for begin in 1...end {
                if cmp(i1: maxIndex, i2: begin) <= 0 {
                    maxIndex = begin
                }
            }
            
            swap(i1: maxIndex, i2: end)
        }
    }
}

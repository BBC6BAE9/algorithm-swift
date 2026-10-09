//
//  InsertionSort.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

class InsertionSort1<E: Comparable>: Sort<E> {
    
    override func sort() {
        for begin in 1..<array.count {
            var cur = begin
            while cur > 0 && cmp(i1: cur, i2: cur - 1) < 0 {
                swap(i1: cur, i2: cur - 1)
                cur -= 1
            }
        }
    }
}

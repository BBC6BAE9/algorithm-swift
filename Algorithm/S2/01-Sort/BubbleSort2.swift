//
//  BubbleSort2.swift
//  Algo
//
//  Created by hong on 5/30/25.
//

import Foundation

class BubbleSort2<E: Comparable>: Sort<E> {
    
    override func sort() {
        for end in (1..<array.count).reversed() {
            var sorted = true
            for begin in 1...end {
                if cmp(i1: begin, i2: begin - 1) < 0 {
                    swap(i1: begin, i2: begin - 1)
                    sorted = false
                }
            }
            
            if sorted { break }
        }
    }
    
}

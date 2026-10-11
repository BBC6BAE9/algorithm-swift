//
//  main.swift
//  Algo
//
//  Created by hong on 2/22/25.
//

import Foundation

func bbubbleSortX( array: inout [Int]) -> [Int] {
    
    for end in stride(from: array.count, to: 0, by: -1) {
        print(end)
        for begin in stride(from: 1, to: end, by: 1) {
            if (array[begin] < array[begin - 1]) {
                let tmp = array[begin]
                array[begin] = array[begin - 1]
                array[begin - 1] = tmp
            }
        }
    }
    
    return array
}

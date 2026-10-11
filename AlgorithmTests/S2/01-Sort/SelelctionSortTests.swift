//
//  SelelctionSortTests.swift
//  AlgoTests
//
//  Created by hong on 6/5/25.
//

import Testing

struct SelelctionSortTests {
    
    @Test func testSelelctionSort() async throws {
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        selelctionSort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        assert(ret == want)
    }
}


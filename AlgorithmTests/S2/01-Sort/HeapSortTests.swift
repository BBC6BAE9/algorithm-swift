//
//  BubbleSortTests.swift
//  AlgoTests
//
//  Created by hong on 5/20/25.
//

import Testing

struct HeapSortTests {
    @Test func testHeapSort() async throws {
        let hs = HeapSort<Int>()
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        hs.sort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        print(hs.description)
        
        assert(ret == want)
    }
}

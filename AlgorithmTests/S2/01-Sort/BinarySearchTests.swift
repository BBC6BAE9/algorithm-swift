//
//  TestBinarySearch.swift
//  AlgoTests
//
//  Created by hong on 6/5/25.
//

import Testing

struct BinarySearchTests {

    @Test func testBinarySearch() async throws {
        let bs = BinarySearch()
        
        let input = [9, 10, 28, 29, 34, 37, 56]
        
        let ret1 = bs.indexOf(array: input, v: 9)
        
        let want1 = 0
        
        
        let ret2 = bs.indexOf(array: input, v: 10)
        
        let want2 = 1
        
        assert(ret1 == want1)
        assert(ret2 == want2)
    }
    
    @Test func testBinarySearchSearch() async throws {
        let bs = BinarySearch()
        
        let input = [2, 4, 8, 8, 8, 12, 14]
        
        assert(bs.search(array: input, v: 5) == 2)
        assert(bs.search(array: input, v: 1) == 0)
        assert(bs.search(array: input, v: 15) == 7)
        assert(bs.search(array: input, v: 8) == 5)
    }
    

}

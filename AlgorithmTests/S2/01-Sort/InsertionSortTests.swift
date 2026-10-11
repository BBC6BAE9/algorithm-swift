//
//  Test.swift
//  AlgoTests
//
//  Created by hong on 6/5/25.
//

import Testing

struct InsertionSortTests {

    @Test func testInsertionSort1() async throws {
        let hs = InsertionSort1<Int>()
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        hs.sort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        print(hs.description)
        
        assert(ret == want)
    }
    
    
    @Test func testInsertionSort2() async throws {
        let hs = InsertionSort2<Int>()
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        hs.sort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        print(hs.description)
        
        assert(ret == want)
    }
    
    @Test func testInsertionSort3() async throws {
        let hs = InsertionSort3<Int>()
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        hs.sort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        print(hs.description)
        
        assert(ret == want)
    }
    
}

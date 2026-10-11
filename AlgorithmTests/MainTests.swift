//
//  MainTests.swift
//  AlgorithmTests
//
//  Created by hong on 10/11/26.
//

import Testing

struct MainTests {

    @Test func testFib1() async throws {
        var array = [11, 18, 12]
        let ret = bbubbleSortX(array: &array)
        let want = [11, 12, 18]
        
        assert(ret == want, "element want \(want), but got \(ret)")
    }

}


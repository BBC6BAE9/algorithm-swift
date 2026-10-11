//
//  HashTests.swift
//  AlgoTests
//
//  Created by hong on 5/17/25.
//

import Testing

struct HashTests {

    @Test func testHashValueString() async throws {
        let ret = Hash.hashValue(string: "jack")
        let want = 3254239
        
        assert(ret == want)
    }

}

//
//  FibonacciTests.swift
//  AlgoTests
//
//  Created by hong on 2/22/25.
//

import Testing

struct FibonacciTests {

    @Test func testFib1() async throws {
        let ret = fib1(12)
        let want = 144
        assert(ret == want, "element want \(want), but got \(ret)")
    }
    
    @Test func testFib2() async throws {
        let ret = fib2(12)
        let want = 144
        assert(ret == want, "element want \(want), but got \(ret)")
    }

}

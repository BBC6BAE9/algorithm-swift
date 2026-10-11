//
//  Solution1823Tests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct Solution1823Tests {

    @Test func testFindTheWinner() async throws {
        let ret = Solution1823().findTheWinner(8, 3)
        let want = 7
        assert(ret == want)
    }
    
    @Test func testFindTheWinner1() async throws {
        let ret = Solution1823().findTheWinner(5, 2)
        let want = 3
        assert(ret == want)
    }
    
    @Test func testFindTheWinner2() async throws {
        let ret = Solution1823().findTheWinner(8, 0)
        let want = 8
        assert(ret == want)
    }
    
}

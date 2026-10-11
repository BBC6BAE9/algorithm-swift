//
//  Solution1Tests.swift
//  AlgoTests
//
//  Created by hong on 3/4/25.
//

import Testing

struct Solution1Tests {

    @Test func testTwoSum() async throws {
        let ret = Solution1().twoSum([2,7,11,15], 9)
        let want = [0, 1]
        #expect(ret == want)
    }

}

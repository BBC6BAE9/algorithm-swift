//
//  Solution42Tests.swift
//  AlgoTests
//
//  Created by hong on 3/4/25.
//

import Testing

struct Solution42Tests {

    @Test func testTrap() async throws {
        let input = [0,1,0,2,1,0,1,3,2,1,2,1]
        let ret = Solution42().trap(input)
        let want = 6
        #expect(ret == want)
    }
    
    @Test func testTrap1() async throws {
        let input = [4,2,0,3,2,5]
        let ret = Solution42().trap(input)
        let want = 9
        #expect(ret == want)
    }
    
    
    @Test func testTrap2() async throws {
        let input = [4,2]
        let ret = Solution42().trap(input)
        let want = 0
        #expect(ret == want)
    }

}

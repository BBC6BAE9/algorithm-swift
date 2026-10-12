//
//  SolutionTests.swift
//  AlgorithmTests
//
//  Created by hong on 10/12/26.
//

import Testing

struct SolutionTests {

    @Test func testTwoSum() async throws {
        
        let ret = Solution().twoSum([2,7,11, 15], 9)
        let want = [0,1]
        
        #expect(ret == want)
        
    }

}

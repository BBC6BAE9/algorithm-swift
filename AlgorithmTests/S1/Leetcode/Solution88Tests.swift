//
//  Solution20Tests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct Solution88Tests {

    @Test func testIsValid1() async throws {
        var nums1 = [1,2,3,0,0,0]
        let m = 3
        let nums2 = [2,5,6]
        let n = 3
        
        Solution().merge(&nums1, m, nums2, n)
        let want = [1,2,2,3,5,6]
        
        #expect(nums1 == want)
    }
    
}

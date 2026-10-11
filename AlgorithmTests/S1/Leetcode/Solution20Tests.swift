//
//  Solution20Tests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct Solution20Tests {

    @Test func testIsValid1() async throws {
        let ret = Solution20().isValid("()")
        let want = true
        
        #expect(ret == want)
    }
    
    @Test func testIsValid2() async throws {
        
        let ret1 = Solution20().isValid("()[]{}")
        let want1 = true
        
        #expect(ret1 == want1)

    }
    
    @Test func testIsValid3() async throws {
        
        let ret2 = Solution20().isValid("(]")
        let want2 = false
        
        #expect(ret2 == want2)
    }
    
    @Test func testIsValid4() async throws {
        
        let ret2 = Solution20().isValid("([])")
        let want2 = true
        
        #expect(ret2 == want2)
    }
    
    @Test func testIsValid5() async throws {
        
        let ret2 = Solution20().isValid("([[[[[[[[{]]]]]]]])")
        let want2 = false
        
        #expect(ret2 == want2)
    }
    
    
    @Test func testIsValid6() async throws {
        
        let ret = Solution20().isValid2("([[[[[[[[{]]]]]]]])")
        let want = false
        
        #expect(ret == want)
    }
    
    @Test func testIsValid7() async throws {
        
        let ret = Solution20().isValid2("[")
        let want = false
        
        #expect(ret == want)
    }
    
    @Test func testIsValid8() async throws {
        
        let ret = Solution20().isValid2("]")
        let want = false
        
        #expect(ret == want)
    }
    
    @Test func testIsValid9() async throws {
        
        let ret = Solution20().isValid2("")
        let want = false
        
        #expect(ret == want)
    }
}

//
//  Solution150Tests.swift
//  AlgoTests
//
//  Created by hong on 3/4/25.
//

import Testing

struct Solution150Tests {

    @Test func testEvalRPN1() async throws {
        let ret = Solution150().evalRPN(["2","1","+","3","*"])
        let want = 9
        #expect(ret == want)
    }
    
    @Test func testEvalRPN2() async throws {
        let ret = Solution150().evalRPN(["4","13","5","/","+"])
        let want = 6
        print("---------")
        print("---------")
        #expect(ret == want)
    }
    
    @Test func testEvalRPN3() async throws {
        let ret = Solution150().evalRPN(["10","6","9","3","+","-11","*","/","*","17","+","5","+"])
        let want = 22
        #expect(ret == want)
    }
    
}

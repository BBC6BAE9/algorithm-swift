//
//  Solution232Tests.swift
//  AlgoTests
//
//  Created by hong on 3/4/25.
//

import Testing

struct Solution232Tests {

    @Test func testMyQueue() async throws {
        let myqueue = MyQueue()
        myqueue.push(1)
        myqueue.push(2)
        myqueue.push(3)
        
        _ = myqueue.pop()
        
        let ret =  myqueue.peek()
        let want = 2
        #expect(ret == want)
    }

}

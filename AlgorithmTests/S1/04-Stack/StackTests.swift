//
//  StackTests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct StackTests {

    @Test func testPush() async throws {
        let stack = Stack<Int>()
        stack.push(element: 10)
        #expect(stack.size() == 1)
    }
    
    @Test func testPop() async throws {
        let stack = Stack<Int>()
        stack.push(element: 10)
        stack.push(element: 10)
        stack.push(element: 10)
        _ = stack.pop()
        #expect(stack.size() == 2)
        
        _ = stack.pop()
        _ = stack.pop()
        #expect(stack.size() == 0)
    }
    
    @Test func testTop() async throws {
        let stack = Stack<Int>()
        stack.push(element: 10)
        stack.push(element: 10)
        stack.push(element: 10)
        stack.push(element: 10)
        _ = stack.pop()
        _ = stack.pop()
        _ = stack.pop()
        _ = stack.pop()

        #expect(stack.top() == nil)
    }

}

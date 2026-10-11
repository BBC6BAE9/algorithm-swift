//
//  CircleQueueTests.swift
//  AlgoTests
//
//  Created by hong on 3/4/25.
//

import Testing

struct CircularQueueTests {

    @Test func testCircleQueue() async throws {
        let queue = CircularQueue<Int>()
        queue.enQueue(1)
        queue.enQueue(2)
        queue.enQueue(3)
        queue.enQueue(4)
        queue.enQueue(5)
        queue.enQueue(6)
        queue.enQueue(7)
        queue.enQueue(8)
        queue.enQueue(9)
        queue.enQueue(10)
        queue.enQueue(11)
        queue.enQueue(12)
        
        
        #expect(queue.size() == 12)
        _ = queue.deQueue()
        #expect(queue.size() == 11)
        print("------------")
        print("------------")
        print("------------")
        print("------------")
        print("------------")
    }

}

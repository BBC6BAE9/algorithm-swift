//
//  QueueTests.swift
//  AlgoTests
//
//  Created by hong on 3/4/25.
//

import Testing

struct QueueTests {

    @Test func testQueue() async throws {
        let queue = Queue<Int>()
        
        queue.enQueue(element: 1)
        queue.enQueue(element: 2)
        queue.enQueue(element: 3)
        queue.enQueue(element: 4)
        queue.enQueue(element: 5)
        queue.enQueue(element: 6)
        queue.enQueue(element: 7)
        
        _ = queue.deQueue()
        #expect(queue.front() == 2)
    }

}

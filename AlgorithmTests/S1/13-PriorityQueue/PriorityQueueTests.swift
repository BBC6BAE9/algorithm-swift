//
//  PriorityQueueTests.swift
//  AlgoTests
//
//  Created by hong on 5/29/25.
//

import Testing

struct PriorityQueueTests {

    @Test func testPriorityQueue() async throws {
        let pq = PriorityQueue<Person>()
        pq.enQueue(element: Person(name: "Jack", boneBreak: 2))
        pq.enQueue(element: Person(name: "Rose", boneBreak: 10))
        pq.enQueue(element: Person(name: "Jake", boneBreak: 5))
        pq.enQueue(element: Person(name: "James", boneBreak: 15))
        
        let person = pq.deQueue()!
        let ret = person.name
        let want = "James"
        
        assert(ret == want, "person name want \(want), but got \(ret)")
    }

}

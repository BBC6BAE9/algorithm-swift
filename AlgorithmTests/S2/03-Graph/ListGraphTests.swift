//
//  ListGraphTests.swift
//  AlgoTests
//
//  Created by hong on 6/6/25.
//

import Testing

struct ListGraphTests {

    @Test func testGraph() async throws {
        let graph = ListGraph<String, Int>()

        graph.addEdge("V1", "V0", 9)
        graph.addEdge("V1", "V2", 3)
        graph.addEdge("V2", "V0", 2)
        graph.addEdge("V2", "V3", 5)
        graph.addEdge("V3", "V4", 1)
        graph.addEdge("V0", "V4", 6)

    }

}

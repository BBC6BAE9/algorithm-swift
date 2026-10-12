//
//  UnionFindTests.swift
//  AlgorithmTests
//
//  Created by hong on 10/11/26.
//

import Testing

struct UnionFindTests {
    
    @Test func testQuickFind() async throws {
        let qf = QuickFind(capacity: 12)
        qf.union(0, 1)
        qf.union(0, 3)
        qf.union(0, 4)
        qf.union(0, 4)
        qf.union(2, 3)
        qf.union(2, 5)
        
        qf.union(6, 7)
        qf.union(8, 10)
        qf.union(9, 10)
        qf.union(9, 11)
        
        #expect(qf.isSame(0, 6) == false)
        #expect(qf.isSame(0, 5))
    }

    @Test(arguments: [0, 1, 6])
    func testQuickUnionInitialization(capacity: Int) {
        let qu = QuickUnion(capacity: capacity)

        #expect(qu.parents == Array(0..<capacity))
        for v in 0..<capacity {
            #expect(qu.find(v: v) == v)
            #expect(qu.isSame(v, v))
        }
    }

    @Test func testQuickUnion() {
        let qu = QuickUnion(capacity: 12)
        qu.union(0, 1)
        qu.union(0, 3)
        qu.union(0, 4)
        qu.union(0, 4)
        qu.union(2, 3)
        qu.union(2, 5)

        qu.union(6, 7)
        qu.union(8, 10)
        qu.union(9, 10)
        qu.union(9, 11)

        #expect(!qu.isSame(0, 6))
        #expect(qu.isSame(0, 5))

        // 使用非根节点合并两个已有集合，所有成员都应连通
        qu.union(4, 6)
        for v in 0..<8 {
            #expect(qu.isSame(0, v))
        }
        for v in 8..<12 {
            #expect(qu.isSame(8, v))
            #expect(!qu.isSame(0, v))
        }
    }

    @Test func testQuickUnionFindThroughMultipleParents() {
        let qu = QuickUnion(capacity: 128)
        for v in 0..<127 {
            qu.union(v, v + 1)
        }

        for v in 0..<128 {
            #expect(qu.find(v: v) == 127)
        }

        let parents = qu.parents
        qu.union(0, 127)
        qu.union(127, 0)
        qu.union(64, 64)
        #expect(qu.parents == parents)
        #expect(qu.isSame(0, 127))
    }
}

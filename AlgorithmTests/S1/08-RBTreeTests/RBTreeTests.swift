//
//  RBTreeTests.swift
//  AlgoTests
//
//  Created by hong on 4/21/25.
//

import Testing

struct RBTreeTests {

    @Test func testRBTreeAdd() async throws {
        let data:[Int] = [55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50]
        
        let rbTree = RBTree<Int>()
        for item in data {
            rbTree.add(element: item)
        }
        
        print(rbTree.asString)
        
        let ret = rbTree.root

        let want = 70
        assert(ret?.element == want)
    }
    
    @Test func testRBTreeRemove() async throws {
        let data:[Int] = [55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50]
        
        let rbTree = RBTree<Int>()
        for item in data {
            rbTree.add(element: item)
        }
        
        
        print(rbTree.asString)

        for item in data {
            rbTree.remove(element: item)
            print("-----------------")
            print(rbTree.asString)
        }
        
        assert(rbTree.root == nil)
    }

}

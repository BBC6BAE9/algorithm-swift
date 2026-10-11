//
//  BinarySearchTreeTests.swift
//  AlgoTests
//
//  Created by hong on 4/16/25.
//

import Testing

struct BinarySearchTreeTests {

    @Test func test() async throws {
        let data:[Int] = [7, 4, 9, 2, 5, 8, 11, 3]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        let ret = bst.root?.left?.left?.right?.element
        let want = 3
        print(bst.asString)
        assert(ret == want)
    }

    @Test func testPreorderTraversal() async throws {
        let data:[Int] = [7, 4, 9, 2, 5, 8, 11, 3, 12, 1]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        bst.preorderTraversal()
    }
    
    @Test func testInorderTraversal() async throws {
        let data:[Int] = [7, 4, 2, 1, 3, 5, 9, 8, 11, 10, 12]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        bst.inorderTraversal()
    }
    
    @Test func testPostorderTraversal() async throws {
        let data:[Int] = [7, 4, 2, 1, 3, 5, 9, 8, 11, 10, 12]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        bst.postorderTraversal()
    }
    
    @Test func testLevelOrderTraversal() async throws {
        let data:[Int] = [7, 4, 2, 1, 3, 5, 9, 8, 11, 10, 12]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        bst.levelOrderTravrtsal()
    }
    
    @Test func testHeight() async throws {
        let data:[Int] = [7, 4, 2, 1, 3, 5, 9, 8, 11, 10, 12]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        let ret = bst.height()
        let want = 4
        assert(ret == want)
    }
    
    @Test func testHeight2() async throws {
        let data:[Int] = [7, 4, 2, 1, 3, 5, 9, 8, 11, 10, 12]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        let ret = bst.height2()
        let want = 4
        assert(ret == want)
    }

    @Test func testIsCompleteWithTrue() async throws {
        let data:[Int] = [7, 4, 9, 2, 5]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        let ret = bst.isComplete()
        let want = true
        assert(ret == want)
    }
    
    @Test func testIsCompleteWithFalse() async throws {
        let data:[Int] = [7, 4, 9, 2, 1]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        let ret = bst.isComplete()
        let want = false
        assert(ret == want)
    }
    
    @Test func testRemove() async throws {
        let data:[Int] = [7, 4, 9, 2, 5, 8, 11, 3, 12, 1]
        let bst = BST<Int>()
        for item in data {
            bst.add(element: item)
        }
        
        let ret1 = bst.root?.left?.left?.left?.element
        assert(ret1 == 1)
        
        bst.remove(element: 1)
        
        let ret2 = bst.root?.left?.left?.left?.element
        assert(ret2 == nil)
    }
}

//
//  Solution226Tests.swift
//  AlgoTests
//
//  Created by ihenryhuang on 2025/4/17.
//

import Testing

struct Solution226Tests {
    
    @Test func testInvertTree1() async throws {
        // [4,2,7,1,3,6,9]

        let rootNode = TreeNode(4)
        rootNode.left = TreeNode(2)
        rootNode.right = TreeNode(7)
        rootNode.left?.left = TreeNode(1)
        rootNode.left?.right = TreeNode(3)
        rootNode.right?.left = TreeNode(6)
        rootNode.right?.right = TreeNode(9)
        
        let invertTreeNode = Solution226().invertTree1(rootNode)
        
        let ret1 = invertTreeNode?.left?.left?.val
        let want1 = 9
        
        let ret2 = invertTreeNode?.right?.right?.val
        let want2 = 1
        
        assert(ret1 == want1)
        assert(ret2 == want2)
    }
    
    @Test func testInvertTree2() async throws {
        // [4,2,7,1,3,6,9]

        let rootNode = TreeNode(4)
        rootNode.left = TreeNode(2)
        rootNode.right = TreeNode(7)
        rootNode.left?.left = TreeNode(1)
        rootNode.left?.right = TreeNode(3)
        rootNode.right?.left = TreeNode(6)
        rootNode.right?.right = TreeNode(9)
        
        let invertTreeNode = Solution226().invertTree2(rootNode)
        
        let ret1 = invertTreeNode?.left?.left?.val
        let want1 = 9
        
        let ret2 = invertTreeNode?.right?.right?.val
        let want2 = 1
        
        assert(ret1 == want1)
        assert(ret2 == want2)
    }
    
    @Test func testInvertTree3() async throws {
        // [4,2,7,1,3,6,9]

        let rootNode = TreeNode(4)
        rootNode.left = TreeNode(2)
        rootNode.right = TreeNode(7)
        rootNode.left?.left = TreeNode(1)
        rootNode.left?.right = TreeNode(3)
        rootNode.right?.left = TreeNode(6)
        rootNode.right?.right = TreeNode(9)
        
        let invertTreeNode = Solution226().invertTree3(rootNode)
        
        let ret1 = invertTreeNode?.left?.left?.val
        let want1 = 9
        
        let ret2 = invertTreeNode?.right?.right?.val
        let want2 = 1
        
        assert(ret1 == want1)
        assert(ret2 == want2)
    }
}

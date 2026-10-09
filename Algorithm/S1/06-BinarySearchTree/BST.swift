//
//  BinarySearchTree.swift
//  Algo
//
//  Created by hong on 4/16/25.
//

// 相关练习：Solution226 翻转二叉树
import Foundation

/// 二叉搜索树
class BST<T: Comparable>: BinaryTree<T> {
    
    func add(element: T) {
        
        guard let root = root else { // 添加第一个节点
            root = createNode(element: element, parent: nil)
            size += 1;
            afterAdd(node: root!)
            return
        }
        
        var node: BinaryTree<T>.Node<T>?  = root
        
        
        var parentNode: BinaryTree<T>.Node<T> = root
        var cmp: Int = 0
        while node != nil {
            
            parentNode = node!
            
            // 添加的不是第一个节点
            cmp = compare(e1: element, e2: node!.element)
            if cmp > 0 {
                node = node!.right
            } else if cmp < 0 {
                node = node!.left
            } else {
                // 相等，说明元素重复，直接返回
                return
            }
        }
        
        let newNode: BinaryTree<T>.Node<T> = createNode(element: element, parent: parentNode)
        
        if cmp > 0 {
            parentNode.right = newNode
        }else{
            parentNode.left = newNode
        }
        
        size += 1
        afterAdd(node: newNode)
    }
    
    public func remove(element: T) {
        remove(node: node(element: element))
    }
    
    // 添加Node之后的调整
    public func afterAdd(node: BinaryTree<T>.Node<T>) {
            
    }

    // 删除Node之后的调整
    public func afterRemove(node: BinaryTree<T>.Node<T>) {
            
    }
    
    private func removeElement(element: T) {
        remove(node: node(element: element))
    }
    
    func contains(element: T) -> Bool {
        node(element: element) != nil
    }
    
    private func remove(node: BinaryTree<T>.Node<T>?) {
        guard var node = node else { return }
        
        size -= 1
        
        // 1、删除叶子节点：直接删除
        // 2、删除度为1的节点：用子节点替代原节点的位置即可
        // 3、删除度为2的节点：找到前驱节点或者后继节点来替代原节点的位置，以维持搜索二叉树的性质
        
        if node.hasTwoChildren() {
            if let s = successor(node: node) {
                node.element = s.element
                node = s
            }
        }
        
        // 删除node节点（node的度必然是1或者0）
        let replacementNode = node.left != nil ? node.left : node.right
        if replacementNode != nil { // node是度为1的节点
            replacementNode?.parent = node.parent
            if node.parent == nil {
                root = replacementNode
            }else if node == node.parent?.left {
                node.parent?.left = replacementNode
            }else {
                node.parent?.right = replacementNode
            }
            
            // 删除节点之后的处理
            afterRemove(node: node)
            
        } else if(node.parent == nil){ // node是叶子节点且是根节点
            root = nil
            
            // 删除节点之后的处理
            afterRemove(node: node)
        }else{ // node是叶子节点，但不是根节点
            if(node == node.parent?.left) {
                node.parent?.left = nil
            } else {
                node.parent?.right = nil
            }
            
            // 删除节点之后的处理
            afterRemove(node: node)
        }
    }
    
    /// 根据元素寻找节点
    private func node(element: T) -> BinaryTree<T>.Node<T>? {
        var node = root
        while node != nil {
            let cmp = compare(e1: element, e2: node!.element)
            if cmp == 0 {return node}
            if cmp > 0 {
                node = node?.right
            }else{
                node = node?.left
            }
        }
        return nil
    }
    
    /// 比较两个元素的大小
    /// - Returns: 0代表两个元素相等 大于0代表e1大于e2 返回值小于0代表e1小于e2
    private func compare(e1: T, e2: T) -> Int {
        if e1 == e2 {
            return 0
        }else if e1 > e2 {
            return 1
        }else{
            return -1
        }
    }
    
    /// 判断是否是 完全二叉树
    /// 定义：叶子结点只能出现在最下层和次下层，且最下层的叶子结点集中在树的左部
    func isComplete() -> Bool {
        
        // 空树认为不是完全二叉树
        guard let root = root else {
            return false
        }
        
        // 非空树
        let queue = Queue<Node<T>>()
        queue.enQueue(element: root)
        
        var needLeaf = false
        
        while !queue.isEmpty() {
            let node = queue.deQueue()!
            
            if needLeaf && !node.isLeaf() {
                return false
            }
            
            if let leftNode = node.left {
                queue.enQueue(element: leftNode)
            } else if node.right != nil {
                return false
            }
            
            if let rightNode = node.right {
                queue.enQueue(element: rightNode)
            } else {
                needLeaf = true
            }
        }
        
        return true
    }
}

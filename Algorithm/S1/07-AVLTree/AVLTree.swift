//
//  AVLTree.swift
//  Algo
//
//  Created by hong on 4/19/25.
//

import Foundation

class AVLTree<T: Comparable>: BBST<T> {
    
    // MARK: 重写父类方法
    
    override func createNode(element: T, parent: BinaryTree<T>.Node<T>?) -> BinaryTree<T>.Node<T> {
        return AVLNode<T>(element: element, parent: parent)
    }
        
    // MARK: Override
    // 实现恢复平衡的逻辑
    override func afterAdd(node: BinaryTree<T>.Node<T>) {
        var node: (BinaryTree<T>.Node<T>)? = node
        while (node != nil) {
            if (isBlanced(node: node!)) {
                // 发现是平衡的，顺便更新节点的高度
                updateHeight(node: node!)
            } else {
                // 恢复平衡
                rebalance(grand: node!)
                // rebalance2(grand: node!)
                break
            }
            node = node?.parent
        }
    }
    
    override func afterRemove(node: BinaryTree<T>.Node<T>) {
        var node: (BinaryTree<T>.Node<T>)? = node
        while (node != nil) {
            if (isBlanced(node: node!)) {
                // 发现是平衡的，顺便更新节点的高度
                updateHeight(node: node!)
            } else {
                // 恢复平衡
                rebalance(grand: node!)
                // rebalance2(grand: node!)
            }
            node = node?.parent
        }
    }
    
    private func updateHeight(node: (BinaryTree<T>.Node<T>)?) {
        let avlNode: AVLNode<T>? = node as? AVLTree<T>.AVLNode<T>
        avlNode?.updateHeight()
    }
    
    // MARK: 统一处理节点的思路重新平衡二叉树
    
    private func rebalance(grand: Node<T>) {
        let grand = grand as! AVLNode<T>
        let parent: AVLNode<T> = grand.tallerChild() as! AVLNode<T>
        let node: AVLNode<T> = parent.tallerChild() as! AVLNode<T>
        
        if parent.isLeftChild() {
            if node.isLeftChild() { // LL
                rotate(r: grand,
                       b: node,
                       c: node.right,
                       d: parent,
                       e: parent.right,
                       f: grand)
            }else{ // LR
                rotate(r: grand,
                       b: parent,
                       c: node.left,
                       d: node,
                       e: node.right,
                       f: grand)
            }
        } else {
            if node.isLeftChild() { // RL
                rotate(r: grand,
                       b: grand,
                       c: node.left,
                       d: node,
                       e: node.right,
                       f: parent)
            }else{ // RR
                rotate(r: grand,
                       b: grand,
                       c: parent.left,
                       d: parent,
                       e: node.left,
                       f: node)
            }
        }
    }
    
    override func rotate(r: BinaryTree<T>.Node<T>, b: BinaryTree<T>.Node<T>, c: BinaryTree<T>.Node<T>?, d: BinaryTree<T>.Node<T>, e: BinaryTree<T>.Node<T>?, f: BinaryTree<T>.Node<T>) {
        super.rotate(r: r, b: b, c: c, d: d, e: e, f: f)
        updateHeight(node: b)
        updateHeight(node: f)
        updateHeight(node: d)
    }
    
    override func afterRotate(grand: BinaryTree<T>.Node<T>, parent: BinaryTree<T>.Node<T>?, child: BinaryTree<T>.Node<T>?) {
        super.afterRotate(grand: grand, parent: parent, child: child)
        // 更新高度
        updateHeight(node: grand)
        updateHeight(node: parent)
    }
    
    // MARK: 直观的思路重新平衡二叉树
    /// 【核心代码】
    /// - Parameter node: 高度最低的那个不平衡节点
    private func rebalance2(grand: Node<T>) {
        let grand = grand as! AVLNode<T>
        let parent: AVLNode<T> = grand.tallerChild() as! AVLNode<T>
        let node: AVLNode<T> = parent.tallerChild() as! AVLNode<T>
        
        if parent.isLeftChild() {
            if node.isLeftChild() { // LL
                rotateRight( grand)
            }else{ // LR
                rotateLeft( parent)
                rotateRight( grand)
            }
        } else { // R
            if node.isLeftChild() { // RL
                rotateRight( parent)
                rotateLeft( grand)
            }else{ // RR
                rotateLeft( grand)
            }
        }
    }
    

        
    private func isBlanced(node: BinaryTree<T>.Node<T>) -> Bool {
        abs((node as! AVLNode<T>).balanceFactor()) <= 1
    }
    
    private class AVLNode<E: Comparable>: BinaryTree<T>.Node<T> {
        
        var height: Int = 1
        
        override init(element: T, parent: BinaryTree<T>.Node<T>?) {
            super.init(element: element, parent: parent)
        }
        
        /// 平衡因子
        public func balanceFactor() -> Int {
            // 左子树的高度 - 右子树的高度
            let leftHeight = left == nil ? 0 : (left as! AVLNode<T>).height
            let rightHeight = right == nil ? 0 : (right as! AVLNode<T>).height
            
            return leftHeight - rightHeight
        }
        
        public func updateHeight() {
            let leftHeight = left == nil ? 0 : (left as! AVLNode<T>).height
            let rightHeight = right == nil ? 0 : (right as! AVLNode<T>).height
            height = 1 + max(leftHeight, rightHeight)
        }
        
        
        func tallerChild() -> Node<T>? {
            let leftHeight = left == nil ? 0 : (left as! AVLNode<T>).height
            let rightHeight = right == nil ? 0 : (right as! AVLNode<T>).height
            
            if (leftHeight > rightHeight) { return left }
            if (leftHeight < rightHeight) { return right }
            
            return isLeftChild() ? left : right
        }
    }
    
}

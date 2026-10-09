//
//  RBTree.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation

let RED = false
let BLACK = true

class RBTree<T: Comparable>: BBST<T> {
    
    /// 染色
    private func color(node:Node<T>?,
                       color: Bool) -> Node<T>? {
        guard let node = node as? RBNode<T> else { return nil }
        node.color = color
        return node
    }
    
    /// 染红
    private func red(_ node:Node<T>?) -> Node<T>? {
        return color(node: node, color: RED)
    }
    
    /// 染黑
    private func black(_ node:Node<T>?) -> Node<T>? {
        return color(node: node, color: BLACK)
    }
    
    /// 获取节点的颜色
    private func colorOf(_ node: Node<T>?) -> Bool {
        return node == nil ? BLACK : (node as! RBNode<T>).color
    }
    
    /// 判断节点是否是黑色
    private func isBlack(_ node: Node<T>?) -> Bool {
        return colorOf(node) == BLACK
    }
    
    /// 判断节点是否是黑色
    private func isRed(_ node: Node<T>?) -> Bool {
        return colorOf(node) == RED
    }
    
    // MARK: override
    override func afterAdd(node: BinaryTree<T>.Node<T>) {
        let parent = node.parent
        
        // 添加的是根节点或者上溢到达了根节点
        guard let parent = parent else {
            _ = black(node)
            return
        }
        
        // 如果父节点是黑色，直接返回
        if isBlack(parent) { return }
        
        // 叔父节点
        let uncle = parent.sibling()
        
        // 祖父节点
        let grand = parent.parent
        
        if isRed(uncle) { // 叔父节点是红色【上溢】
            _ = black(parent)
            _ = black(uncle)
            
            afterAdd(node: red(grand)!)
            return
        }
        
        // 叔父节点不是红色
        if (parent.isLeftChild()) { // L
            _ = red(grand)
            if node.isLeftChild() { // LL
                _ = black(parent)
            } else { // LR
                _ = black(node)
                rotateLeft( parent)
            }
            rotateRight(grand)
        } else { // R
            _ = red(grand)
            if node.isLeftChild() { // RL
                _ = black(node)
                rotateRight(parent)
            } else { // RR
                _ = black(parent)
            }
            rotateLeft( grand)
        }
    }
    
    override func afterRemove(node: BinaryTree<T>.Node<T>)
    {
        
        if isRed(node) {
            _ = black(node)
            return
        }
        
        let parent = node.parent
        
        // 删除的是根节点
        if (parent == nil) {
            return
        }
        
        // 删除的是黑色的叶子节点【下溢】
        let left = parent?.left == nil || node.isLeftChild();
        
        var sibling = left ? parent?.right : parent?.left
        if (left) { // 被删除的节点在左边，兄弟节点在右边
            if isRed(sibling) {
                _ = black(sibling)
                _ = red(parent)
                rotateLeft(parent)
                
                //更换兄弟
                sibling = parent?.right
            }
            
            if(isBlack(sibling?.left) && isBlack(sibling?.right)) { // 兄弟节点没有一个红色子节点
                
                let parentBlack = isBlack(parent)
                
                _ = black(parent)
                _ = red(sibling)
                if parentBlack {
                    afterRemove(node: parent!)
                }
            } else { // 兄弟节点至少有一个是红色节点, 向兄弟节点借元素
                // 兄弟节点的左边是黑色
                if(isBlack(sibling?.right)) {
                    rotateRight(sibling)
                    sibling = parent?.right
                }
                
                _ = color(node: sibling, color: colorOf(parent))
                _ = black(sibling?.right)
                _ = black(parent)
                
                rotateLeft(parent)
            }
        } else { // 被删除的节点在右边，兄弟节点在左边
            if isRed(sibling) {
                _ = black(sibling)
                _ = red(parent)
                rotateRight(parent)
                
                //更换兄弟
                sibling = parent?.left
            }
            
            if(isBlack(sibling?.left) && isBlack(sibling?.right)) { // 兄弟节点没有一个红色子节点
                
                let parentBlack = isBlack(parent)
                
                _ = black(parent)
                _ = red(sibling)
                if parentBlack {
                    afterRemove(node: parent!)
                }
            } else { // 兄弟节点至少有一个是红色节点, 向兄弟节点借元素
                // 兄弟节点的左边是黑色
                if(isBlack(sibling?.left)) {
                    rotateLeft(sibling)
                    sibling = parent?.left
                }
                
                _ = color(node: sibling, color: colorOf(parent))
                _ = black(sibling?.left)
                _ = black(parent)
                
                rotateRight(parent)
            }
        }
    }
    
    override func createNode(element: T, parent: BinaryTree<T>.Node<T>?) -> BinaryTree<T>.Node<T> {
        return RBNode<T>(element: element, parent: parent)
    }
    
    /// 红黑树节点
    private class RBNode<E: Comparable>: BinaryTree<T>.Node<T> {
        var color: Bool = RED
        
        override init(element: T, parent: BinaryTree<T>.Node<T>?) {
            super.init(element: element, parent: parent)
        }
    }
}

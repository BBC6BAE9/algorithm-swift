//
//  TreeMap.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation

class TreeMap<K: Comparable, V: Equatable>: MapProtocol {
    
    public var size: Int = 0
        
    private var root: Node<K, V>?
    
    func getSize() -> Int {
        return size
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func clear() {
        root = nil
        size = 0
    }
    
    func put(key: K?, value: V) -> V? {
        guard let key = key else {
            fatalError("key must not be nil")
        }
        
        guard let root = root else { // 添加第一个节点
            root = Node(key: key, value: value, parent: nil)
            size += 1;
            afterPut(node: root!)
            return nil
        }
        
        var node: Node<K, V>? = root
        var parent: Node<K, V> = root
        var cmp: Int = 0
        while node != nil {
            
            parent = node!
            
            // 添加的不是第一个节点
            cmp = compare(e1: key, e2: node!.key)
            if cmp > 0 {
                node = node!.right
            } else if cmp < 0 {
                node = node!.left
            } else {
                // 相等，说明元素重复，直接返回
                node!.key = key
                let oldValue: V = node!.value
                node!.value = value
                return oldValue
            }
        }
        
        let newNode: Node<K, V> = Node(key: key, value: value, parent: parent)
        
        if cmp > 0 {
            parent.right = newNode
        }else{
            parent.left = newNode
        }
        
        size += 1
        afterPut(node: newNode)
        return nil
        
    }
    
    func get(key: K) -> V? {
        return node(key: key)?.value
    }
    
    func remove(key: K) {
        _ = remove(node: node(key: key))
    }
    
    func containsKey(key: K) -> Bool {
        return node(key: key) != nil
    }
    
    func containsValue(value: V?) -> Bool {
        guard let root = root else { return false }
        let queue = Queue<Node<K, V>>()
        queue.enQueue(element: root)
        
        while(!queue.isEmpty()) {
            if let node = queue.deQueue() {
                if (valEquals(v1: value, v2: node.value)) { return true }

                if let leftNode = node.left{
                    queue.enQueue(element: leftNode)
                }
                
                if let rightNode = node.right{
                    queue.enQueue(element: rightNode)
                }
            }
        }
        return false
    }
    
    private func valEquals(v1:V?, v2:V?) -> Bool {
        return v1 == nil ? v2 == nil : v1 == v2
    }
    
    func getRoot() -> Any? {
        return root
    }
    
    private func afterPut(node: Node<K, V>) {
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
            
            afterPut(node: red(grand)!)
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
    
    /// 比较两个元素的大小
    /// - Returns: 0代表两个元素相等 大于0代表e1大于e2 返回值小于0代表e1小于e2
    private func compare(e1: K, e2: K) -> Int {
        if e1 == e2 {
            return 0
        }else if e1 > e2 {
            return 1
        }else{
            return -1
        }
    }

    /// 染色
    private func color(node:Node<K, V>?,
                       color: Bool) -> Node<K, V>?
    {
        guard let node = node else { return nil }
        node.color = color
        return node
    }
    
    /// 染红
    private func red(_ node:Node<K, V>?) -> Node<K, V>? {
        return color(node: node, color: RED)
    }
    
    /// 染黑
    private func black(_ node:Node<K, V>?) -> Node<K, V>? {
        return color(node: node, color: BLACK)
    }
    
    /// 获取节点的颜色
    private func colorOf(_ node: Node<K, V>?) -> Bool {
        return node == nil ? BLACK : node!.color
    }
    
    /// 判断节点是否是黑色
    private func isBlack(_ node: Node<K, V>?) -> Bool {
        return colorOf(node) == BLACK
    }
    
    /// 判断节点是否是黑色
    private func isRed(_ node: Node<K, V>?) -> Bool {
        return colorOf(node) == RED
    }
    
    // 左旋转
    private func rotateLeft(_ grand: Node<K, V>?) {
        guard let grand = grand else {
            return
        }
        let parent = grand.right
        let child = parent?.left
        grand.right = child
        parent?.left = grand
        
        afterRotate(grand: grand, parent: parent, child: child)
    }
    
    // 右旋转
    private func rotateRight(_ grand: Node<K, V>?) {
        guard let grand = grand else {
            return
        }
        let parent = grand.left
        let child = parent?.right
        grand.left = child
        parent?.right = grand
        
        afterRotate(grand: grand, parent: parent, child: child)
    }
    
    
    private func afterRotate(grand: Node<K, V>, parent: Node<K, V>?, child: Node<K, V>?) {
        // 让parent称为子树的根节点
        parent?.parent = grand.parent
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if (grand.isRightChild()) {
            grand.parent?.right = parent
        } else {
            root = parent
        }
        
        if let child = child {
            child.parent = grand
        }
        
        grand.parent = parent
    }
    
    /// 根据元素寻找节点
    private func node(key: K) -> Node<K, V>? {
        var node = root
        while node != nil {
            let cmp = compare(e1: key, e2: node!.key)
            if cmp == 0 {return node}
            if cmp > 0 {
                node = node?.right
            }else{
                node = node?.left
            }
        }
        return nil
    }
    
    private func remove(node: Node<K, V>?) -> V? {
        guard var node = node else { return nil }
        
        size -= 1
        
        let oldValue = node.value
        // 1、删除叶子节点：直接删除
        // 2、删除度为1的节点：用子节点替代原节点的位置即可
        // 3、删除度为2的节点：找到前驱节点或者后继节点来替代原节点的位置，以维持搜索二叉树的性质
        
        if node.hasTwoChildren() {
            if let s = successor(node: node) {
                node.key = s.key
                node.value = s.value
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
        
        return oldValue
    }
    
    private func afterRemove(node: Node<K, V>)
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
    
    // 获取一个节点的前驱节点
    // 前驱节点（predecessor）中序遍历时的前一个节点
    private  func predecessor(node: Node<K, V>?) -> Node<K, V>? {
        var node = node
        if node == nil {
            return nil
        }
        
        // 前驱节点在左子树中（left.right.right.right...）
        if let leftNode = node?.left {
            var p: Node<K, V>? = leftNode
            while (p?.right != nil){
                p = p?.right
            }
            return p
        }
        
        // 从父节点、祖父节点中寻找前驱节点
        while(node?.parent != nil && node == node?.parent?.left){
            node = node?.parent
        }
        
        return node?.parent
    }
    
    // 获取一个节点的后继节点
    private func successor(node: Node<K, V>?) -> Node<K, V>? {
        var node = node
        if node == nil {
            return nil
        }
        
        // 前驱节点在左子树中（right.left.left.left...）
        if let leftNode = node?.right {
            var p: Node<K, V>? = leftNode
            while (p?.right != nil){
                p = p?.left
            }
            return p
        }
        
        // 从父节点、祖父节点中寻找前驱节点
        while(node?.parent != nil && node == node?.parent?.right){
            node = node?.parent
        }
        
        return node?.parent
    }
    
    private class Node<K1:Equatable, V1: Equatable> : Equatable{
        static func == (lhs: Node<K1, V1>, rhs: Node<K1, V1>) -> Bool {
            return (lhs.key == rhs.key) && (lhs.value == rhs.value)
        }
        
        var key: K1
        var value: V1
        var color: Bool = RED
        
        var left: Node<K1, V1>?
        var right: Node<K1, V1>?
        var parent: Node<K1, V1>?
        
        init(key: K1, value: V1, parent: Node<K1, V1>?) {
            self.key = key
            self.value = value
            self.parent = parent
        }
        
        /// 是否是叶子节点
        func isLeaf() -> Bool {
            return left == nil && right == nil
        }
        
        /// 是否有两个子节点
        func hasTwoChildren() -> Bool {
            return left != nil && right != nil
        }
        
        /// 当前节点是否是父节点的左子节点
        func isLeftChild() -> Bool {
            return parent != nil && self == parent?.left
        }
        
        /// 当前节点是否是父节点的右子节点
        func isRightChild() -> Bool {
            return parent != nil && self == parent?.right
        }
        
        /// 访问兄弟节点
        func sibling() -> Node<K1, V1>? {
            if isLeftChild() {
                return parent?.right
            }
            
            if isRightChild() {
                return parent?.left
            }
            
            return nil
        }
    }
    
}

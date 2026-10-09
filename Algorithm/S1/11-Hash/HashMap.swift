////
////  HashMap.swift
////  Algo
////
////  Created by hong on 5/19/25.
////
//
//import Foundation
//
//// 容量要求是2的幂，我们选16，也可以表示为1<<4
//let DEFAULT_INITIAL_CAPACITY: Int = 16
//
///// 自己实现一个Hash表
///// 注：value直接使用红黑树进行存储（JDK中如果哈希表的容量>=64且单向链表的节点数量大于8时，存储结构会从单向链表转为红黑树）
//public class HashMap<K: Hashable, V: Equatable> : MapProtocol {
//    
//    private var size: Int = 0
//    
//    private var table: FixedSizeArray<Node<K, V>?> = .init(capacity: DEFAULT_INITIAL_CAPACITY)
//    
//    func getSize() -> Int {
//        return size
//    }
//    
//    func isEmpty() -> Bool {
//        return size == 0
//    }
//    
//    func clear() {
//        if size == 0 { return }
//        
//        size = 0
//        
//        for i in 0..<table.size() {
//            table[i] = nil
//        }
//    }
//    
//    func put(key: K?, value: V) -> V? {
//        // TODO: 这个地方先简单处理成非空
//        guard let key = key else { return nil }
//        
//        let index = index(key: key)
//        // 取出index位置的红黑树根节点
//        
//        var root = table[index]!
//        
//        // 根节点的处理
//        if root == nil {
//            let tmpRoot = Node(key: key, value: value, parent: nil)
//            root = tmpRoot
//            table[index] = root
//            size += 1
//            afterPut(node: tmpRoot)
//            return nil
//        }
//        
//        // 添加新的节点到红黑树上
//        
//        var node: Node<K, V>? = root
//        var parent: Node<K, V> = root!
//        var cmp: Int = 0
//        
//        let h1 = key.hashValue
//        
//        while node != nil {
//            
//            parent = node!
//            
//            // 添加的不是第一个节点
//            cmp = compare(k1: key, k2: node!.key, h1: h1, h2: node!.hash)
//            if cmp > 0 {
//                node = node!.right
//            } else if cmp < 0 {
//                node = node!.left
//            } else {
//                // 相等，说明元素重复，直接返回
//                node!.key = key
//                let oldValue: V = node!.value
//                node!.value = value
//                return oldValue
//            }
//        }
//        
//        let newNode: Node<K, V> = Node(key: key, value: value, parent: parent)
//        
//        if cmp > 0 {
//            parent.right = newNode
//        }else{
//            parent.left = newNode
//        }
//        
//        size += 1
//        afterPut(node: newNode)
//        return nil
//    }
//    
//    func get(key: K) -> V? {
//        return nil
//    }
//    
//    func remove(key: K) {
//        
//    }
//    
//    func containsKey(key: K) -> Bool {
//        return false
//    }
//    
//    func containsValue(value: V?) -> Bool {
//        return false
//    }
//    
//    private class Node<K1:Hashable, V1: Equatable> : Equatable{
//        
//        var hash: Int
//        var key: K1
//        var value: V1
//        var color: Bool = RED
//        
//        var left: Node<K1, V1>?
//        var right: Node<K1, V1>?
//        var parent: Node<K1, V1>?
//        
//        init(key: K1, value: V1, parent: Node<K1, V1>?) {
//            self.key = key
//            self.hash = key.hashValue
//            self.value = value
//            self.parent = parent
//        }
//        
//        /// 是否是叶子节点
//        func isLeaf() -> Bool {
//            return left == nil && right == nil
//        }
//        
//        /// 是否有两个子节点
//        func hasTwoChildren() -> Bool {
//            return left != nil && right != nil
//        }
//        
//        /// 当前节点是否是父节点的左子节点
//        func isLeftChild() -> Bool {
//            return parent != nil && self == parent?.left
//        }
//        
//        /// 当前节点是否是父节点的右子节点
//        func isRightChild() -> Bool {
//            return parent != nil && self == parent?.right
//        }
//        
//        /// 访问兄弟节点
//        func sibling() -> Node<K1, V1>? {
//            if isLeftChild() {
//                return parent?.right
//            }
//            
//            if isRightChild() {
//                return parent?.left
//            }
//            
//            return nil
//        }
//        
//        static func == (lhs: Node<K1, V1>, rhs: Node<K1, V1>) -> Bool {
//            return (lhs.key == rhs.key) && (lhs.value == rhs.value)
//        }
//        
//    }
//    
//    /// 根据key生成索引（在桶数组中的位置）
//    private func index(key: K?) -> Int {
//        guard let key = key else {
//            return 0
//        }
//        let hash = key.hashValue
//        // hash >> 16的意思是高16位和低16位进行位运算，是为了得到更加均匀的哈希
//        return (hash ^ (hash >> 16)) & (table.length - 1)
//    }
//     
//    /// 比较两个元素的大小
//    /// - Returns: 0代表两个元素相等 大于0代表e1大于e2 返回值小于0代表e1小于e2
//    /// - Parameters:
//    ///   - k1:
//    ///   - k2:
//    ///   - h1: k1的hashcode
//    ///   - h2: k2的hashcode
//    private func compare(k1: K,
//                         k2: K,
//                         h1: Int,
//                         h2: Int) -> Int
//    {
//        // TODO: 这里其实是简单的处理了一下K，让他不为空，和原课程的可空有一些出入
//
//        // 先比较hash值
//        let result = h1 - h2
//        
//        if result != 0  {
//            return result
//        }
//        
//        // hash值相等，比较equals
//        if (k1 == k2) {
//            return 0
//        }
//
//        return result
//    }
//    
//    private func afterRemove(node: Node<K, V>)
//    {
//        
//        if isRed(node) {
//            _ = black(node)
//            return
//        }
//        
//        let parent = node.parent
//        
//        // 删除的是根节点
//        if (parent == nil) {
//            return
//        }
//        
//        // 删除的是黑色的叶子节点【下溢】
//        let left = parent?.left == nil || node.isLeftChild();
//        
//        var sibling = left ? parent?.right : parent?.left
//        if (left) { // 被删除的节点在左边，兄弟节点在右边
//            if isRed(sibling) {
//                _ = black(sibling)
//                _ = red(parent)
//                rotateLeft(parent)
//                
//                //更换兄弟
//                sibling = parent?.right
//            }
//            
//            if(isBlack(sibling?.left) && isBlack(sibling?.right)) { // 兄弟节点没有一个红色子节点
//                
//                let parentBlack = isBlack(parent)
//                
//                _ = black(parent)
//                _ = red(sibling)
//                if parentBlack {
//                    afterRemove(node: parent!)
//                }
//            } else { // 兄弟节点至少有一个是红色节点, 向兄弟节点借元素
//                // 兄弟节点的左边是黑色
//                if(isBlack(sibling?.right)) {
//                    rotateRight(sibling)
//                    sibling = parent?.right
//                }
//                
//                _ = color(node: sibling, color: colorOf(parent))
//                _ = black(sibling?.right)
//                _ = black(parent)
//                
//                rotateLeft(parent)
//            }
//        } else { // 被删除的节点在右边，兄弟节点在左边
//            if isRed(sibling) {
//                _ = black(sibling)
//                _ = red(parent)
//                rotateRight(parent)
//                
//                //更换兄弟
//                sibling = parent?.left
//            }
//            
//            if(isBlack(sibling?.left) && isBlack(sibling?.right)) { // 兄弟节点没有一个红色子节点
//                
//                let parentBlack = isBlack(parent)
//                
//                _ = black(parent)
//                _ = red(sibling)
//                if parentBlack {
//                    afterRemove(node: parent!)
//                }
//            } else { // 兄弟节点至少有一个是红色节点, 向兄弟节点借元素
//                // 兄弟节点的左边是黑色
//                if(isBlack(sibling?.left)) {
//                    rotateLeft(sibling)
//                    sibling = parent?.left
//                }
//                
//                _ = color(node: sibling, color: colorOf(parent))
//                _ = black(sibling?.left)
//                _ = black(parent)
//                
//                rotateRight(parent)
//            }
//        }
//    }
//    
//    private func afterPut(node: Node<K, V>) {
//        let parent = node.parent
//        
//        // 添加的是根节点或者上溢到达了根节点
//        guard let parent = parent else {
//            _ = black(node)
//            return
//        }
//        
//        // 如果父节点是黑色，直接返回
//        if isBlack(parent) { return }
//        
//        // 叔父节点
//        let uncle = parent.sibling()
//        
//        // 祖父节点
//        let grand = parent.parent
//        
//        if isRed(uncle) { // 叔父节点是红色【上溢】
//            _ = black(parent)
//            _ = black(uncle)
//            
//            afterPut(node: red(grand)!)
//            return
//        }
//        
//        // 叔父节点不是红色
//        if (parent.isLeftChild()) { // L
//            _ = red(grand)
//            if node.isLeftChild() { // LL
//                _ = black(parent)
//            } else { // LR
//                _ = black(node)
//                rotateLeft( parent)
//            }
//            rotateRight(grand)
//        } else { // R
//            _ = red(grand)
//            if node.isLeftChild() { // RL
//                _ = black(node)
//                rotateRight(parent)
//            } else { // RR
//                _ = black(parent)
//            }
//            rotateLeft( grand)
//        }
//    }
//    
//    // 左旋转
//    private func rotateLeft(_ grand: Node<K, V>?) {
//        guard let grand = grand else {
//            return
//        }
//        let parent = grand.right
//        let child = parent?.left
//        grand.right = child
//        parent?.left = grand
//        
//        afterRotate(grand: grand, parent: parent, child: child)
//    }
//    
//    // 右旋转
//    private func rotateRight(_ grand: Node<K, V>?) {
//        guard let grand = grand else {
//            return
//        }
//        let parent = grand.left
//        let child = parent?.right
//        grand.left = child
//        parent?.right = grand
//        
//        afterRotate(grand: grand, parent: parent, child: child)
//    }
//    
//    
//    private func afterRotate(grand: Node<K, V>, parent: Node<K, V>?, child: Node<K, V>?) {
//        // 让parent称为子树的根节点
//        parent?.parent = grand.parent
//        if grand.isLeftChild() {
//            grand.parent?.left = parent
//        } else if (grand.isRightChild()) {
//            grand.parent?.right = parent
//        } else {
//            root = parent
//        }
//        
//        if let child = child {
//            child.parent = grand
//        }
//        
//        grand.parent = parent
//    }
//    
//    /// 染红
//    private func red(_ node:Node<K, V>?) -> Node<K, V>? {
//        return color(node: node, color: RED)
//    }
//    
//    /// 染黑
//    private func black(_ node:Node<K, V>?) -> Node<K, V>? {
//        return color(node: node, color: BLACK)
//    }
//    
//    /// 染色
//    private func color(node:Node<K, V>?,
//                       color: Bool) -> Node<K, V>?
//    {
//        guard let node = node else { return nil }
//        node.color = color
//        return node
//    }
//    
//    /// 判断节点是否是黑色
//    private func isBlack(_ node: Node<K, V>?) -> Bool {
//        return colorOf(node) == BLACK
//    }
//    
//    /// 判断节点是否是黑色
//    private func isRed(_ node: Node<K, V>?) -> Bool {
//        return colorOf(node) == RED
//    }
//    
//    /// 获取节点的颜色
//    private func colorOf(_ node: Node<K, V>?) -> Bool {
//        return node == nil ? BLACK : node!.color
//    }
//}

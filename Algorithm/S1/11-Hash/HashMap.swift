//
//  HashMap.swift
//  Algo
//
//  Created by hong on 5/19/25.
//

import Foundation

// 桶数组容量保持为2的幂，初始容量为16
let DEFAULT_INITIAL_CAPACITY: Int = 16

/// 自己实现的哈希表，每个桶使用红黑树存储键值对
public class HashMap<K: Hashable, V: Equatable>: Map {

    private var size = 0
    // FixedSizeArray的下标本身返回可选值，不需要再次包装Node?
    private var table = FixedSizeArray<Node>(capacity: DEFAULT_INITIAL_CAPACITY)

    public init() {}

    public func getSize() -> Int {
        return size
    }

    public func isEmpty() -> Bool {
        return size == 0
    }

    public func clear() {
        for i in 0..<table.length {
            table[i] = nil
        }
        size = 0
    }

    /// 添加或覆盖键值对，覆盖时返回旧值；不存储nil键
    @discardableResult
    public func put(key: K?, value: V) -> V? {
        guard let key = key else { return nil }
        let hash = hash(key: key)

        if let existing = node(key: key, hash: hash) {
            let oldValue = existing.value
            existing.value = value
            return oldValue
        }

        resizeIfNeeded()
        let newNode = Node(key: key, value: value, hash: hash)
        insert(newNode, at: index(hash: hash))
        size += 1
        return nil
    }

    public func get(key: K) -> V? {
        return node(key: key, hash: hash(key: key))?.value
    }

    public func remove(key: K) {
        guard var removed = node(key: key, hash: hash(key: key)) else { return }
        size -= 1

        // 度为2时，用右子树中最小的节点覆盖，再删除后继节点
        if removed.left != nil, var successor = removed.right {
            while let left = successor.left {
                successor = left
            }
            removed.key = successor.key
            removed.value = successor.value
            removed.hash = successor.hash
            removed = successor
        }

        let bucketIndex = index(hash: removed.hash)
        let parent = removed.parent
        let isLeft = removed === parent?.left
        let replacement = removed.left ?? removed.right

        replacement?.parent = parent
        if let parent = parent {
            if isLeft {
                parent.left = replacement
            } else {
                parent.right = replacement
            }
        } else {
            table[bucketIndex] = replacement
        }

        if removed.color == .black {
            afterRemove(replacement, parent: parent, isLeft: isLeft, at: bucketIndex)
        }

        removed.parent = nil
        removed.left = nil
        removed.right = nil
    }

    public func containsKey(key: K) -> Bool {
        return node(key: key, hash: hash(key: key)) != nil
    }

    public func containsValue(value: V?) -> Bool {
        guard let value = value else { return false }

        for i in 0..<table.length {
            guard let root = table[i] else { continue }
            var stack = [root]
            while let current = stack.popLast() {
                if current.value == value { return true }
                if let left = current.left { stack.append(left) }
                if let right = current.right { stack.append(right) }
            }
        }
        return false
    }

    private enum Color {
        case red
        case black
    }

    private class Node {
        var key: K
        var value: V
        var hash: Int
        var color: Color = .red
        var left: Node?
        var right: Node?
        // 子节点由父节点持有，反向引用使用weak，避免循环引用
        weak var parent: Node?

        init(key: K, value: V, hash: Int) {
            self.key = key
            self.value = value
            self.hash = hash
        }
    }

    private func hash(key: K) -> Int {
        let hash = UInt(bitPattern: key.hashValue)
        return Int(bitPattern: hash ^ (hash >> 16))
    }

    private func index(hash: Int) -> Int {
        return hash & (table.length - 1)
    }

    private func node(key: K, hash: Int) -> Node? {
        return node(in: table[index(hash: hash)], key: key, hash: hash)
    }

    private func node(in root: Node?, key: K, hash: Int) -> Node? {
        guard let root = root else { return nil }
        if hash < root.hash {
            return node(in: root.left, key: key, hash: hash)
        }
        if hash > root.hash {
            return node(in: root.right, key: key, hash: hash)
        }
        if key == root.key { return root }

        // 哈希相同不代表键相同；旋转后碰撞节点可能出现在两侧
        return node(in: root.left, key: key, hash: hash)
            ?? node(in: root.right, key: key, hash: hash)
    }

    /// 插入已经确认不存在的节点，不改变size，供扩容时复用
    private func insert(_ newNode: Node, at bucketIndex: Int) {
        guard let root = table[bucketIndex] else {
            newNode.color = .black
            table[bucketIndex] = newNode
            return
        }

        var current: Node? = root
        var parent = root
        var isLeft = false
        while let node = current {
            parent = node
            // 同哈希的不同键先挂到右侧，查找时会检查两侧
            isLeft = newNode.hash < node.hash
            current = isLeft ? node.left : node.right
        }

        newNode.parent = parent
        if isLeft {
            parent.left = newNode
        } else {
            parent.right = newNode
        }
        afterPut(newNode, at: bucketIndex)
    }

    private func resizeIfNeeded() {
        // 在下一次插入会超过0.75负载因子时，将桶数组扩为两倍
        guard size >= table.length - table.length / 4 else { return }
        let oldTable = table
        table = FixedSizeArray<Node>(capacity: oldTable.length << 1)

        for i in 0..<oldTable.length {
            guard let root = oldTable[i] else { continue }
            var stack = [root]
            while let current = stack.popLast() {
                // 先保留旧子节点，再清理关系并插入新桶
                if let left = current.left { stack.append(left) }
                if let right = current.right { stack.append(right) }
                current.left = nil
                current.right = nil
                current.parent = nil
                current.color = .red
                insert(current, at: index(hash: current.hash))
            }
            oldTable[i] = nil
        }
    }

    private func afterPut(_ node: Node, at bucketIndex: Int) {
        guard let parent = node.parent else {
            node.color = .black
            return
        }
        if isBlack(parent) { return }
        guard let grand = parent.parent else {
            parent.color = .black
            return
        }

        let parentIsLeft = parent === grand.left
        let uncle = parentIsLeft ? grand.right : grand.left
        grand.color = .red

        if isRed(uncle) {
            parent.color = .black
            uncle?.color = .black
            afterPut(grand, at: bucketIndex)
            return
        }

        if parentIsLeft {
            if node === parent.left { // LL
                parent.color = .black
            } else { // LR
                node.color = .black
                rotateLeft(parent, at: bucketIndex)
            }
            rotateRight(grand, at: bucketIndex)
        } else {
            if node === parent.right { // RR
                parent.color = .black
            } else { // RL
                node.color = .black
                rotateRight(parent, at: bucketIndex)
            }
            rotateLeft(grand, at: bucketIndex)
        }
    }

    private func afterRemove(
        _ replacement: Node?,
        parent: Node?,
        isLeft: Bool,
        at bucketIndex: Int
    ) {
        if isRed(replacement) {
            replacement?.color = .black
            return
        }

        var current = replacement
        var parent = parent
        var isLeft = isLeft

        while let ancestor = parent {
            let left = current.map { $0 === ancestor.left } ?? isLeft
            var sibling = left ? ancestor.right : ancestor.left

            // 红兄弟先旋转，转成黑兄弟的情况
            if isRed(sibling) {
                sibling?.color = .black
                ancestor.color = .red
                if left {
                    rotateLeft(ancestor, at: bucketIndex)
                    sibling = ancestor.right
                } else {
                    rotateRight(ancestor, at: bucketIndex)
                    sibling = ancestor.left
                }
            }

            if isBlack(sibling?.left) && isBlack(sibling?.right) {
                sibling?.color = .red
                if isRed(ancestor) {
                    ancestor.color = .black
                    return
                }
                // 父节点也是黑色，将下溢向上继续处理
                current = ancestor
                parent = ancestor.parent
                isLeft = ancestor === parent?.left
                continue
            }

            if left {
                if isBlack(sibling?.right) {
                    sibling?.left?.color = .black
                    sibling?.color = .red
                    if let sibling = sibling {
                        rotateRight(sibling, at: bucketIndex)
                    }
                    sibling = ancestor.right
                }
                sibling?.color = ancestor.color
                ancestor.color = .black
                sibling?.right?.color = .black
                rotateLeft(ancestor, at: bucketIndex)
            } else {
                if isBlack(sibling?.left) {
                    sibling?.right?.color = .black
                    sibling?.color = .red
                    if let sibling = sibling {
                        rotateLeft(sibling, at: bucketIndex)
                    }
                    sibling = ancestor.left
                }
                sibling?.color = ancestor.color
                ancestor.color = .black
                sibling?.left?.color = .black
                rotateRight(ancestor, at: bucketIndex)
            }
            return
        }
        current?.color = .black
    }

    private func rotateLeft(_ grand: Node, at bucketIndex: Int) {
        guard let parent = grand.right else { return }
        let child = parent.left
        grand.right = child
        parent.left = grand
        afterRotate(grand: grand, parent: parent, child: child, at: bucketIndex)
    }

    private func rotateRight(_ grand: Node, at bucketIndex: Int) {
        guard let parent = grand.left else { return }
        let child = parent.right
        grand.left = child
        parent.right = grand
        afterRotate(grand: grand, parent: parent, child: child, at: bucketIndex)
    }

    private func afterRotate(grand: Node, parent: Node, child: Node?, at bucketIndex: Int) {
        let grandParent = grand.parent
        let wasLeft = grand === grandParent?.left
        parent.parent = grandParent
        if let grandParent = grandParent {
            if wasLeft {
                grandParent.left = parent
            } else {
                grandParent.right = parent
            }
        } else {
            // 每个桶有自己的根节点
            table[bucketIndex] = parent
        }
        child?.parent = grand
        grand.parent = parent
    }

    private func isBlack(_ node: Node?) -> Bool {
        return node?.color != .red
    }

    private func isRed(_ node: Node?) -> Bool {
        return node?.color == .red
    }
}

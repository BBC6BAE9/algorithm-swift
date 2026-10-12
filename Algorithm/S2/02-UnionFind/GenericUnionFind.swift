//
//  GenericUnionFind.swift
//  Algorithm
//

/// 支持任意Hashable类型的普通QuickUnion并查集
class GenericUnionFind<V: Hashable> {

    private var nodes: [V: Node] = [:]

    /// 创建一个单元素集合，已有元素不会重复创建
    func makeSet(_ v: V) {
        if nodes[v] != nil { return }
        nodes[v] = Node(value: v)
    }

    /// 查找元素所在集合的根节点值，未添加的元素返回nil
    func find(v: V) -> V? {
        return findNode(v)?.value
    }

    /// 合并两个元素所在的集合，未添加的元素不参与合并
    func union(_ v1: V, _ v2: V) {
        guard let p1 = findNode(v1), let p2 = findNode(v2), p1 !== p2 else {
            return
        }

        p1.parent = p2
    }

    /// 判断两个已添加的元素是否属于同一个集合
    func isSame(_ v1: V, _ v2: V) -> Bool {
        guard let p1 = findNode(v1), let p2 = findNode(v2) else {
            return false
        }
        return p1 === p2
    }

    private func findNode(_ v: V) -> Node? {
        guard var root = nodes[v] else { return nil }
        while let parent = root.parent, parent !== root {
            root = parent
        }
        return root
    }

    private class Node {
        let value: V
        // nodes字典持有所有节点，弱引用避免根节点引用自身造成循环引用
        weak var parent: Node?
        init(value: V) {
            self.value = value
            self.parent = self
        }
    }
}

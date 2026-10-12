//
//  UnionFind.swift
//  Algorithm
//
//  Created by hong on 10/11/26.
//

import Foundation

/// 并查集也叫做不相交集合（DIsjoint Set）
/// 查找（Find）：查找元素所在的集合（这里的集合不是特指Set这种数据结构，是指广义的数据集合）
/// 合并（Union）：将两个元素所在的集合合并为一个集合

/// 常见思路
/// QuickFind
/// QuickUnion（使用这种思路）

/// 假设并查集处理的数据都是整型，那么可以用整型数组来存储数据
///
///
///

// 接口定义
protocol UnionFind {
    
    /// 查找V所属的集合（根节点）
    func find(v: Int) -> Int
    
    /// 合并V1，V2所属的集合
    func union(_ v1: Int, _ v2: Int)

    /// 检查V1，V2是不是属于同一集合
    func isSame(_ v1: Int, _ v2: Int) -> Bool
}

extension UnionFind {
    func isSame(_ v1: Int, _ v2: Int) -> Bool {
        return find(v: v1) == find(v: v2)
    }
}

// 初始化：每个元素各自属于一个单元素集合（所有元素独立）


class QuickFind: UnionFind {
    
    private(set) var parents: [Int]
    
    init(capacity: Int) {
        if capacity < 0 {
            fatalError("capacity must be >= 0")
        }
        
        self.parents = Array(0..<capacity)
    }
    
    func find(v: Int) -> Int {
        rangeCheck(v: v)
        return parents[v]
    }
    
    func rangeCheck(v: Int) {
        if(v < 0 || v >= parents.count) {
            fatalError("v is out of bounds")
        }
    }
    
    func union(_ v1: Int, _ v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)
        
        // 本身就是在一个集合，不用合并
        if (p1 == p2) { return }
        
        for i in stride(from: 0, to: parents.count, by: 1) {
            if (parents[i] == p1) {
                parents[i] = p2
            }
        }
    }
}

class QuickUnion: UnionFind {
    
    fileprivate(set) var parents: [Int]
    
    init(capacity: Int) {
        if capacity < 0 {
            fatalError("capacity must be >= 0")
        }
        
        self.parents = Array(0..<capacity)
    }
    
    func find(v: Int) -> Int {
        rangeCheck(v: v)
        var root = v
        // 沿着父节点向上查找，直到找到指向自身的根节点
        while (root != parents[root]) {
            root = parents[root]
        }
        return root
    }
    
    func rangeCheck(v: Int) {
        if(v < 0 || v >= parents.count) {
            fatalError("v is out of bounds")
        }
    }
    
    func union(_ v1: Int, _ v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)

        // 本身就是在一个集合，不用合并
        if (p1 == p2) { return }

        // 将V1所在集合的根节点挂到V2所在集合的根节点上
        parents[p1] = p2
    }
}

/// 基于集合大小优化的QuickUnion：小集合合并到大集合
class QuickUnionSize: QuickUnion {

    /// 以根节点为下标，记录对应集合的元素数量
    private(set) var sizes: [Int]

    override init(capacity: Int) {
        if capacity < 0 {
            fatalError("capacity must be >= 0")
        }

        self.sizes = Array(repeating: 1, count: capacity)
        super.init(capacity: capacity)
    }

    override func union(_ v1: Int, _ v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)

        if (p1 == p2) { return }

        if (sizes[p1] < sizes[p2]) {
            parents[p1] = p2
            sizes[p2] += sizes[p1]
        } else {
            parents[p2] = p1
            sizes[p1] += sizes[p2]
        }
    }
}

/// 基于树高优化的QuickUnion：矮树合并到高树
class QuickUnionRank: QuickUnion {

    /// 以根节点为下标，记录对应树的高度（单节点树的高度为1）
    private(set) var ranks: [Int]

    override init(capacity: Int) {
        if capacity < 0 {
            fatalError("capacity must be >= 0")
        }

        self.ranks = Array(repeating: 1, count: capacity)
        super.init(capacity: capacity)
    }

    override func union(_ v1: Int, _ v2: Int) {
        let p1 = find(v: v1)
        let p2 = find(v: v2)

        if (p1 == p2) { return }

        if (ranks[p1] < ranks[p2]) {
            parents[p1] = p2
        } else if (ranks[p1] > ranks[p2]) {
            parents[p2] = p1
        } else {
            // 两棵树高度相同，合并后的根节点高度增加1
            parents[p1] = p2
            ranks[p2] += 1
        }
    }
}

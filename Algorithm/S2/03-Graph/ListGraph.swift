//
//  ListGraph.swift
//  Algorithm
//
//  Created by hong on 10/12/26.
//

import Foundation

/// 邻接表实现
class ListGraph<V: Hashable, E>: Graph {

    // 这张图的所有顶点
    private var vertices: HashMap<V, Vertex> = HashMap()
    
    // 这张图所有的边
    private var edges: HashSet<Edge> = HashSet()

    // 图操作的方法骨架，后续补充具体实现
    func edgesSize() -> Int {
        return edges.size()
    }

    func verticesSize() -> Int {
        return vertices.getSize()
    }

    func addVertex(_ v: V) {
        if (vertices.containsKey(key: v)) {
            return
        }
        
        vertices.put(key: v, value: Vertex(value: v))
    }
 
    func addEdge(_ from: V, _ to: V) {
        addEdge(from, to, nil)
    }

    func addEdge(_ from: V, _ to: V, _ weight: E?) {
        
        // 保证起点有值
        var fromVertex = vertices.get(key: from)
        
        if fromVertex == nil {
            fromVertex = Vertex(value: from)
            vertices.put(key: from, value: fromVertex!)
        }
        
        // 保证终点有值
        
        var toVertex = vertices.get(key: to)
        
        if toVertex == nil {
            toVertex = Vertex(value: to)
            vertices.put(key: to, value: toVertex!)
        }
        
        let edge = Edge(from: fromVertex!, to: toVertex!, weight: weight)
        
        // 不管以前有没有，把这个边删掉
        fromVertex?.outEdges.remove(element: edge)
        toVertex?.inEdges.remove(element: edge)

        edges.remove(element: edge)
        
        fromVertex?.outEdges.add(element: edge)
        toVertex?.inEdges.add(element: edge)
        edges.add(element: edge)
    }

    func removeVertex(v: V) {
        
    }

    func removeEdge(from: V, to: V) {
        
    }

    private class Vertex: Equatable {

        var value: V

        // 指向该顶点的边（入边）
        var inEdges: HashSet<Edge> = HashSet()

        // 从该顶点出发的边（出边）
        var outEdges: HashSet<Edge> = HashSet()

        init(value: V) {
            self.value = value
        }

        static func == (lhs: Vertex, rhs: Vertex) -> Bool {
            return lhs.value == rhs.value
        }
    }

    private class Edge: Hashable {
        // 顶点由vertices持有，边反向引用顶点，避免循环引用
        unowned let from: Vertex
        unowned let to: Vertex
        var weight: E?

        init(from: Vertex, to: Vertex, weight: E?) {
            self.from = from
            self.to = to
            self.weight = weight
        }

        // 起点和终点相同的有向边视为同一条边，权重不参与判重
        static func == (lhs: Edge, rhs: Edge) -> Bool {
            return lhs.from === rhs.from && lhs.to === rhs.to
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(from))
            hasher.combine(ObjectIdentifier(to))
        }
    }
}

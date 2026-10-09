////
////  ListGraph.swift
////  Algo
////
////  Created by hong on 6/6/25.
////
//
//import Foundation
//
//class ListGraph<V, E>: GraphProtocol {
//
//    /// 添加顶点
//    func addVertex(v: V) {
//
//    }
//
//    /// 添加边
//    func addEdge(from: V, to: V, weight: E?) {
//
//    }
//
//    /// 删除顶点
//    func removeVertex(v: V) {
//
//    }
//
//    /// 删除边
//    func removeEdge(from: V, to: V) {
//
//    }
//
//    /// 边数
//    func edgesSize()  -> Int {
//        return 0
//    }
//
//    /// 顶点数
//    func verticesSize()  -> Int {
//        return 0
//    }
//
//    /// 顶点
//    class Vertex<V1, E1> {
//        var value: V1
//        // TODO: 使用hashset
//        var inEdges:  [Edge<V1, E1>] = []
//        var outEdges: [Edge<V1, E1>] = []
//
//        init(value: V1) {
//            self.value = value
//        }
//    }
//
//    /// 边
//    class Edge<V1, E1> {
//        let from: Vertex<V1, E1>
//        let to: Vertex<V1, E1>
//
//        init(from: Vertex<V1, E1>, to: Vertex<V1, E1>) {
//            self.from = from
//            self.to = to
//        }
//    }
//
//}

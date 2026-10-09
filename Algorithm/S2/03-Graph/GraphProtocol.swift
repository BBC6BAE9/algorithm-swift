//
//  GraphProtocol.swift
//  Algo
//
//  Created by hong on 6/5/25.
//

// TODO: 相关的HashMap还没实现，暂时跳过
import Foundation

///// 图的接口定义
//class Graph<V, E> {
//    
//    var fromEdges: LinkedList<Edge<V, E>>
//    var toEdges: LinkedList<Edge<V, E>>
//    
//    init(fromEdges: List<Edge<V, E>>, toEdges: List<Edge<V, E>>) {
//        self.fromEdges = fromEdges
//        self.toEdges = toEdges
//    }
//    
//}

protocol GraphProtocol {
    
    associatedtype V // 顶点的类型
    
    associatedtype E // 边的权重类型
    
    /// 边的数量
    func edgesSize() -> Int
    
    /// 顶点数量
    func verticesSize() -> Int
    
    /// 添加顶点
    func addVertex(v: V)
    
    /// 添加边
    func addEdge(from: V, to: V, weight: E?)
    
    /// 删除顶点
    func removeVertex(v: V)
    
    /// 删除边
    func removeEdge(from: V, to: V,)
    
}



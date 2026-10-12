//
//  GraphProtocol.swift
//  Algo
//
//  Created by hong on 6/5/25.
//

import Foundation

/// 图的接口，对应Java的interface Graph
protocol Graph {
    /// 顶点的数据类型
    associatedtype V

    /// 边的权重类型
    associatedtype E

    /// 边的数量
    func edgesSize() -> Int

    /// 顶点的数量
    func verticesSize() -> Int

    /// 添加顶点
    func addVertex(_ v: V)

    /// 添加无权边
    func addEdge(_ from: V, _ to: V)

    /// 添加边，nil表示没有权重
    func addEdge(_ from: V, _ to: V, _ weight: E?)

    /// 删除顶点
    func removeVertex(v: V)

    ///  删除边
    func removeEdge(from: V, to: V)
}

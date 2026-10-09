//
//  MapProtovol.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation

protocol MapProtocol<K, V> {
    associatedtype K
    associatedtype V
    
    func getSize() -> Int
    func isEmpty() -> Bool
    func clear()
    func put(key: K?, value: V) -> V?
    func get(key: K) -> V?
    func remove(key: K)
    func containsKey(key: K) -> Bool
    func containsValue(value: V?) -> Bool
}


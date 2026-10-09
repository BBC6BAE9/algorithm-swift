//
//  SetProtocol.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation

protocol SetProtocol<E> {
    associatedtype E
    
    func size() -> Int
    func isEmpty() -> Bool
    func clear()
    func contains(element: E) -> Bool
    func add(element: E)
    func remove(element: E)

}

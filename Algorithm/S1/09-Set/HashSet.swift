//
//  HashSet.swift
//  Algorithm
//

/// 基于自写HashMap实现的哈希集合
class HashSet<T: Hashable>: SetProtocol {

    typealias E = T

    private let map = HashMap<T, Bool>()

    func size() -> Int {
        return map.getSize()
    }

    func isEmpty() -> Bool {
        return map.isEmpty()
    }

    func clear() {
        map.clear()
    }

    func contains(element: T) -> Bool {
        return map.containsKey(key: element)
    }

    func add(element: T) {
        map.put(key: element, value: true)
    }

    func remove(element: T) {
        map.remove(key: element)
    }
}

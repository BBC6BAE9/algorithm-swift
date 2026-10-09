//
//  Solution1823.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

// 1823 https://leetcode.cn/problems/find-the-winner-of-the-circular-game/description/

class Solution1823 {
    
    /// 找到胜出者
    /// - Parameters:
    ///   - n: 人数
    ///   - k: 每次数的数
    /// - Returns: 胜出者序号
    func findTheWinner(_ n: Int, _ k: Int) -> Int {
        let list = CircleDoubleLinkedList<Int>()
        for i in 0..<n {
            list.add(element: i+1)
        }
        
        // 指针指向头节点
        list.reset()
        
        while list.size() > 1 {
            if k > 1 {
                for _ in 0..<k-1 {
                    _ = list.next()
                }
            }
            _ = list.remove()
        }
        
        return list.get(index: 0)!
    }
    
    // TODO: 需要一个复杂度更低的solution
    func findTheWinner2(_ n: Int, _ k: Int) -> Int {
        return 0
    }

}

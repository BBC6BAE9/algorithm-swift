//
//  Solution232.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation

// 232. 用栈实现队列
// https://leetcode.cn/problems/implement-queue-using-stacks/


class MyQueue {
    
    var inStack: [Int] = []
    var outStack: [Int] = []
    
    
    func push(_ n: Int) -> Void {
        inStack.append(n)
    }
    
    func pop() -> Int {
        
        while inStack.count != 1 {
            outStack.append((inStack.removeLast()))
        }
        
        let h = inStack.removeLast()
        
        while outStack.count != 0 {
            inStack.append(outStack.removeLast())
        }
        
        return h
    }
    
    func peek() -> Int {
        while inStack.count != 1 {
            outStack.append((inStack.removeLast()))
        }
        
        let h = inStack.last
        
        while outStack.count != 0 {
            inStack.append(outStack.removeLast())
        }
        
        return h!
        
    }
    
    func empty() -> Bool {
        return inStack.isEmpty
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */

//
//  Solution20.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

// 20 https://leetcode.cn/problems/valid-parentheses

extension String {
    
    mutating func push(c: Character) {
        self.append(contentsOf: "\(c)")
    }
    
    mutating func pop() {
        self.removeLast()
    }
    
    func top() -> Character? {
        return self.last
    }
    
}

class Solution20 {
    
    // 合法的括号
    func isValid2(_ s: String) -> Bool {
        
        if s.isEmpty {
            return false
        }
        
        var stack = ""
        
        for char in s {
            let top = stack.top()
            if left(c: char) {
                stack.push(c: char)
            }
            
            if right(c: char)  {
                if pair(l: top, r: char) {
                    stack.pop()
                }else{
                    return false
                }
            }
        }
        
        return stack.count == 0
    }
    
    func isValid(_ s: String) -> Bool {
        let stack = Stack<Character>()
        for char in s {
            let top = stack.top()
            if left(c: char) {
                stack.push(element: char)
            }
            
            if right(c: char) && pair(l: top, r: char) {
                _ = stack.pop()
            }
        }
        
        return stack.size() == 0
    }
    
    func left(c: Character?) -> Bool {
        return  c == "(" || c == "{" || c == "["
    }
    
    func right(c: Character?) -> Bool {
        return  c == ")" || c == "}" || c == "]"
    }
    
    func pair(l: Character?, r: Character?) -> Bool {
        if l == nil || r == nil {
            return false
        }
        
        if l == "(" && r == ")" {
            return true
        }
        
        if l == "[" && r == "]" {
            return true
        }
        
        if l == "{" && r == "}" {
            return true
        }

        return false
    }
}

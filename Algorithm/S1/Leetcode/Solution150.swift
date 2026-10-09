//
//  Solution150.swift
//  Algo
//
//  Created by hong on 3/4/25.
//

import Foundation
// 150、逆波兰表达式 https://leetcode.cn/problems/evaluate-reverse-polish-notation/?utm_source=LCUS&utm_medium=ip_redirect&utm_campaign=transfer2china
class Solution150 {
    
    class Stack {
        private var arr: [String] = []
     
        func push (token: String) {
            arr.append(token)
        }
        
        func pop () -> String? {
            arr.removeLast()
        }
        
        func top () -> String? {
            arr.last
        }
    }

    
    func evalRPN(_ tokens: [String]) -> Int {
        let stack = Stack()
        for token in tokens {
            if token.isOperater() {
                if let operand1 = stack.pop(),
                   let operand2 = stack.pop() {
                   let ret = operate(operand1: operand2, operand2: operand1, operater: token)
                    stack.push(token: "\(ret)")
                }
            }else{
                stack.push(token: token)
            }
        }
        guard let ret = stack.pop(),
              let retInt = Int(ret)
        else {
            fatalError("stack is empty")
        }
        return retInt
    }
    
    func operate(operand1: String , operand2: String, operater: String) -> Int {
        let operand1Int = Int(operand1) ?? 0
        let operand2Int = Int(operand2) ?? 0
        switch operater {
        case "+":
            return operand1Int + operand2Int
        case "-":
            return operand1Int - operand2Int
        case "*":
            return operand1Int * operand2Int
        case "/":
            if (operand2Int == 0) {
                fatalError("operand2Int can not be 0")
            }
            return operand1Int / operand2Int
        default:
            return 0
        }
    }
    
}

extension String {
    
    /// 是不是操作符
    func isOperater() -> Bool{
        return self == "+" || self == "-" || self == "*" || self == "/"
    }
}

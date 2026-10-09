//
//  Fibonacci.swift
//  Algo
//
//  Created by hong on 3/2/25.
//

import Foundation

/**
 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144……
 求第n个斐波那契数，约定F(0)=0、F(1)=1
*/

// 递归的方法
func fib1(_ n :Int) -> Int {
    if (n <= 1) {
        return n
    }

    return fib1(n-1) + fib1(n-2)
}

// 优化的算法
func fib2(_ n :Int) -> Int {
    if (n <= 1) {
        return n
    }

    var first: Int = 0
    var second: Int = 1

    for _ in 0...n-2 {
        let sum = first + second
        first = second
        second = sum
    }

    return second
}

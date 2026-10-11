//
//  TestBubbleSort.swift
//  AlgoTests
//
//  Created by hong on 6/5/25.
//

import Testing

struct BubbleSortTests {

    @Test func testBubbleSortXXXX() async throws {
        
        var input = [10, 9, 29, 28, 37, 56, 34]
                
        let bs = BubbleSort<Int>()

        bs.sort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        assert(ret == want)
    }
    
    @Test func testBubbleSort() async throws {
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        bubbleSort(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        assert(ret == want)
    }
    
    
    @Test func testBubbleSort1() async throws {
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        bubbleSort1(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        assert(ret == want)
    }
    
    @Test func testBubbleSort2() async throws {
        
        var input = [10, 9, 29, 28, 37, 56, 34]
        
        bubbleSort2(array: &input)
        
        let ret = input
        
        let want = [9, 10, 28, 29, 34, 37, 56]

        assert(ret == want)
    }

    @Test func testBubbleSortPerformance() async throws {
    
        var input = (0..<1000).map { _ in Int.random(in: 0...9999) }

        let clock = ContinuousClock()
        let elapsed = clock.measure {
            bubbleSort(array: &input)
        }
        print("bubbleSort的执行时间：\(elapsed.description)")
        
        input = (0..<1000).map { _ in Int.random(in: 0...9999) }
        let elapsed1 = clock.measure {
            bubbleSort1(array: &input)
        }
        print("【优化算法】bubblesort1的执行时间：\(elapsed1.description)")
        
        input = (0..<1000).map { _ in Int.random(in: 0...9999) }
        
        let elapsed2 = clock.measure {
            bubbleSort2(array: &input)
        }
        print("【优化算法】bubblesort2的执行时间：\(elapsed2.description)")
    }
}

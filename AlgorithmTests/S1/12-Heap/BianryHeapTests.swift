//
//  BianryHeapTests.swift
//  AlgoTests
//
//  Created by hong on 5/28/25.
//

import Testing
import CoreFoundation

struct BianryHeapTests {

    @Test func testAdd() async throws {
        
        let heap = BinaryHeap<Int>()
        heap.add(element: 68)
        heap.add(element: 72)
        heap.add(element: 43)
        heap.add(element: 50)
        heap.add(element: 38)
        
        print("\(heap)")
    }
    
    @Test func testRemove() async throws {
        
        let heap = BinaryHeap<Int>()
        heap.add(element: 68)
        heap.add(element: 72)
        heap.add(element: 43)
        heap.add(element: 50)
        heap.add(element: 38)
        heap.add(element: 10)
        heap.add(element: 90)
        heap.add(element: 65)
        
        let ret = heap.remove()
    
        print("\(heap)")
    }
    
    @Test func testReplace() async throws {
        
        let heap = BinaryHeap<Int>()
        heap.add(element: 68)
        heap.add(element: 72)
        heap.add(element: 43)
        heap.add(element: 50)
        heap.add(element: 38)
        heap.add(element: 10)
        heap.add(element: 90)
        heap.add(element: 65)
        
        print("\(heap)")
        
        let ret = heap.replace(element: 70)
    
        print("\(heap)")
    }

    @Test func testHeapify2() async throws {
        let data = [68, 72, 43, 50, 38, 10, 90, 65]
            
        let heap = BinaryHeap(elements: data)
        
        print("\(heap)")
    }
    
}

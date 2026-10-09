//
//  ArrayListTests.swift
//  AlgoTests
//
//  Created by hong on 3/2/25.
//

import Testing

struct ArrayListTests {

    @Test func testAdd1() async throws {
        let arrList = ArrayList<Int>()
        arrList.add(element: 11)
        let ret = arrList.get(index: 0)
        let want = 11
        assert(ret == want, "element want \(want), but got \(ret ?? 0)")
    }
    
    @Test func testAdd2() async throws {
        let arrList = ArrayList<Int>()
        arrList.add(element: 11)
        let ret = arrList.size()
        let want = 1
        assert(ret == want, "array size want \(want), but got \(ret)")
    }
    
    @Test func testAdd3() async throws {
        let arrList = ArrayList<Int>()
        
        arrList.add(element: 7)
        arrList.add(element: 8)
        arrList.add(element: 9)
        arrList.add(element: 10)
        arrList.add(element: 11)
        
        _ = arrList.remove(index: 0)
        let ret = arrList.get(index: 0)
        let want = 8
        assert(ret == want, "array size want \(want), but got \(ret ?? -1)")
        assert(arrList.size() == 4, "array size want \(want), but got \(ret ?? -1)")
    }

    @Test("默认容量下，删除首元素后应保留剩余的 6 个元素")
    func testRemoveFromSevenElements() {
        let arrList = ArrayList<Int>()
        for i in 0..<7 {
            arrList.add(element: i)
        }
        #expect(arrList.size() == 7)

        // 回归场景：删除后剩余 6 个元素，不能把容量从 10 缩到 5。
        let removed = arrList.remove(index: 0)

        #expect(removed == 0)
        #expect(arrList.size() == 6)
        for index in 0..<6 {
            #expect(arrList.get(index: index) == index + 1)
        }
    }
    
    
    @Test func testAdd4() async throws {
        let arrList = ArrayList<Int>(capacity: 10)
        
        for i in 0..<20 {
            arrList.add(element: i)
        }
        
        let ret = arrList.size()
        let want = 20
        assert(ret == want, "array size want \(want), but got \(ret)")
    }
    
    
    @Test func testAdd5() async throws {
        class Person:Equatable {
            static func == (lhs: Person, rhs: Person) -> Bool {
                return lhs === rhs
            }
            
            var name: String
            
            init(name: String) {
                self.name = name
            }
            
            deinit {
                print("person \(name) 被回收")
            }
        }
        
        let arrList = ArrayList<Person>(capacity: 10)
        
        for i in 0..<20 {
            arrList.add(element: Person(name: "\(i)"))
        }
        
        arrList.clear()
        assert(arrList.size() == 0)
    }

}

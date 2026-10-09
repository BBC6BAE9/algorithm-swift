//
//  LinkedListTests.swift
//  AlgoTests
//
//  Created by hong on 3/2/25.
//

import Testing

struct LinkedListTests {

    @Test("读取 index == size 的位置时应触发越界错误")
    func getAtSizeRejectsOutOfBoundsIndex() async {
        await #expect(processExitsWith: .failure) {
            let list = LinkedList<Int>()
            list.add(element: 10)

            // 只有一个元素，合法索引是 0，size() 返回的 1 已经越界。
            _ = list.get(index: list.size())
        }
    }

    @Test func testAdd1() async throws {
        let arrList = LinkedList<Int>()
        arrList.add(element: 11)
        let ret = arrList.get(index: 0)
        let want = 11
        assert(ret == want, "element want \(want), but got \(ret ?? 0)")
    }
    
    @Test func testAdd2() async throws {
        let arrList = LinkedList<Int>()
        arrList.add(element: 11)
        let ret = arrList.size()
        let want = 1
        assert(ret == want, "array size want \(want), but got \(ret)")
    }
    
    @Test func testAdd3() async throws {
        let arrList = LinkedList<Int>()
        
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
    
    
    @Test func testAdd4() async throws {
        let arrList = LinkedList<Int>()
        
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
        
        let arrList = LinkedList<Person>()
        
        for i in 0..<20 {
            arrList.add(element: Person(name: "\(i)"))
        }
        
        arrList.clear()
        assert(arrList.size() == 0)
    }

}

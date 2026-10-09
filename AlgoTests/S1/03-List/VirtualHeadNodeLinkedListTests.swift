//
//  VirtualHeadNodeLinkedListTests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct VirtualHeadNodeLinkedListTests {

    @Test("清空后保留虚拟头节点并可以重新使用")
    func clearThenReusePreservesListState() {
        let list = VirtualHeadNodeLinkedList<Int>()
        list.add(element: 10)
        list.clear()

        #expect(list.isEmpty())
        list.add(element: 20)
        list.add(index: 0, element: 30)
        #expect(list.size() == 2)
        #expect(list.get(index: 0) == 30)
        #expect(list.get(index: 1) == 20)
        #expect(list.contains(element: 30))
        #expect(list.indexOf(element: 20) == 1)
        #expect(list.remove(index: 0) == 30)
        #expect(list.remove(index: 0) == 20)
        #expect(list.isEmpty())

        list.clear()
        list.add(element: 40)
        #expect(list.size() == 1)
        #expect(list.get(index: 0) == 40)
    }

    @Test("查找单个元素及首尾元素时应跳过虚拟头节点")
    func findsFirstAndLastElements() {
        let list = VirtualHeadNodeLinkedList<Int>()
        list.add(element: 10)
        #expect(list.indexOf(element: 10) == 0)
        #expect(list.contains(element: 10))

        list.add(element: 20)
        #expect(list.indexOf(element: 10) == 0)
        #expect(list.indexOf(element: 20) == 1)
        #expect(list.contains(element: 20))
        #expect(list.indexOf(element: 30) == ELEMENT_NOT_FOUND)
        #expect(!list.contains(element: 30))
    }

    @Test("读取 index == size 时应触发越界检查", arguments: [0, 1])
    func getAtSizeRejectsOutOfBoundsIndex(count: Int) async {
        let result = await #expect(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) { [count = count as Int] in
            let list = VirtualHeadNodeLinkedList<Int>()
            for value in 0..<count {
                list.add(element: value)
            }
            _ = list.get(index: list.size())
        }

        let errorOutput = String(decoding: result?.standardErrorContent ?? [], as: UTF8.self)
        #expect(errorOutput.contains("Index out of bounds"))
    }

    @Test("修改 index == size 时应触发越界检查", arguments: [0, 1])
    func setAtSizeRejectsOutOfBoundsIndex(count: Int) async {
        let result = await #expect(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) { [count = count as Int] in
            let list = VirtualHeadNodeLinkedList<Int>()
            for value in 0..<count {
                list.add(element: value)
            }
            _ = list.set(index: list.size(), element: 20)
        }

        let errorOutput = String(decoding: result?.standardErrorContent ?? [], as: UTF8.self)
        #expect(errorOutput.contains("Index out of bounds"))
    }

    @Test func testAdd1() async throws {
        let arrList = VirtualHeadNodeLinkedList<Int>()
        arrList.add(element: 11)
        let ret = arrList.get(index: 0)
        let want = 11
        assert(ret == want, "element want \(want), but got \(ret ?? 0)")
    }
    
    @Test func testAdd2() async throws {
        let arrList = VirtualHeadNodeLinkedList<Int>()
        arrList.add(element: 11)
        let ret = arrList.size()
        let want = 1
        assert(ret == want, "array size want \(want), but got \(ret)")
    }
    
    @Test func testAdd3() async throws {
        let arrList = VirtualHeadNodeLinkedList<Int>()
        
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
        let arrList = VirtualHeadNodeLinkedList<Int>()
        
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
        
        let arrList = VirtualHeadNodeLinkedList<Person>()
        
        for i in 0..<20 {
            arrList.add(element: Person(name: "\(i)"))
        }
        
        arrList.clear()
        assert(arrList.size() == 0)
    }


}

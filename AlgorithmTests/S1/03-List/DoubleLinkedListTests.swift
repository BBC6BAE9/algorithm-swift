//
//  DoubleLinkedListTests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct DoubleLinkedListTests {

    @Test("清空后可以重新插入、查找和删除元素")
    func clearThenReusePreservesListState() {
        let list = DoubleLinkedList<Int>()
        list.add(element: 10)
        list.clear()

        #expect(list.size() == 0)
        list.add(element: 20)
        list.add(element: 30)

        #expect(list.size() == 2)
        #expect(list.get(index: 0) == 20)
        #expect(list.get(index: 1) == 30)
        #expect(list.contains(element: 20))
        #expect(list.contains(element: 30))
        #expect(list.indexOf(element: 20) == 0)
        #expect(list.indexOf(element: 30) == 1)

        #expect(list.remove(index: 1) == 30)
        #expect(list.size() == 1)
        #expect(list.get(index: 0) == 20)
        #expect(!list.contains(element: 30))
        #expect(list.remove(index: 0) == 20)
        #expect(list.isEmpty())

        list.add(element: 40)
        #expect(list.size() == 1)
        #expect(list.get(index: 0) == 40)
        #expect(list.contains(element: 40))
        #expect(list.indexOf(element: 40) == 0)
    }

    @Test("清空链表时应释放所有元素", arguments: [1, 2, 3])
    func clearReleasesElements(count: Int) {
        let list = DoubleLinkedList<Payload>()
        let references = (0..<count).map { _ in
            let payload = Payload()
            list.add(element: payload)
            return WeakPayload(payload)
        }

        #expect(references.allSatisfy { $0.value != nil })
        list.clear()
        #expect(list.isEmpty())
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test("销毁链表时应释放多个元素")
    func deallocationReleasesElements() {
        var list: DoubleLinkedList<Payload>? = DoubleLinkedList()
        let references = (0..<3).map { _ in
            let payload = Payload()
            list?.add(element: payload)
            return WeakPayload(payload)
        }

        #expect(references.allSatisfy { $0.value != nil })
        list = nil
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test("读取 index == size 时应由越界检查拒绝")
    func getAtSizeRejectsOutOfBoundsIndex() async {
        let result = await #expect(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) {
            let list = DoubleLinkedList<Int>()
            list.add(element: 10)
            _ = list.get(index: list.size())
        }

        let errorOutput = String(decoding: result?.standardErrorContent ?? [], as: UTF8.self)
        #expect(errorOutput.contains("Index out of bounds"))
    }

    @Test("修改 index == size 时应由越界检查拒绝")
    func setAtSizeRejectsOutOfBoundsIndex() async {
        let result = await #expect(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) {
            let list = DoubleLinkedList<Int>()
            list.add(element: 10)
            _ = list.set(index: list.size(), element: 20)
        }

        let errorOutput = String(decoding: result?.standardErrorContent ?? [], as: UTF8.self)
        #expect(errorOutput.contains("Index out of bounds"))
    }

    private final class Payload: Equatable {
        static func == (lhs: Payload, rhs: Payload) -> Bool {
            lhs === rhs
        }
    }

    private final class WeakPayload {
        weak var value: Payload?

        init(_ value: Payload) {
            self.value = value
        }
    }

    @Test func testAdd1() async throws {
        let arrList = DoubleLinkedList<Int>()
        arrList.add(element: 11)
        let ret = arrList.get(index: 0)
        let want = 11
        assert(ret == want, "element want \(want), but got \(ret ?? 0)")
    }
    
    @Test func testAdd2() async throws {
        let arrList = DoubleLinkedList<Int>()
        arrList.add(element: 11)
        let ret = arrList.size()
        let want = 1
        assert(ret == want, "array size want \(want), but got \(ret)")
    }
    
    @Test func testAdd3() async throws {
        
        let arrList = DoubleLinkedList<Int>()
        
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
        let arrList = DoubleLinkedList<Int>()
        
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
        
        let arrList = DoubleLinkedList<Person>()
        
        for i in 0..<20 {
            arrList.add(element: Person(name: "\(i)"))
        }
        
        arrList.clear()
        assert(arrList.size() == 0)
    }


}

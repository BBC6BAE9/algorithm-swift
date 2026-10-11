//
//  CircleLinkedListTests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct CircleLinkedListTests {

    @Test("清空后可以重新插入、查找和删除元素", arguments: [0, 1, 3])
    func clearThenReusePreservesListState(count: Int) {
        let list = CircleLinkedList<Int>()
        for element in 0..<count {
            list.add(element: element)
        }
        list.clear()

        #expect(list.isEmpty())
        list.add(element: 20)
        list.add(index: 0, element: 10)
        list.add(index: list.size(), element: 30)

        #expect(list.size() == 3)
        #expect((0..<list.size()).map { list.get(index: $0) } == [10, 20, 30])
        #expect(list.indexOf(element: 20) == 1)
        #expect(list.contains(element: 30))
        #expect(list.remove(index: 0) == 10)
        #expect(list.remove(index: 1) == 30)
        #expect(list.remove(index: 0) == 20)
        #expect(list.isEmpty())

        list.add(element: 40)
        #expect(list.get(index: 0) == 40)
    }

    @Test("清空循环链表时应释放所有元素", arguments: [1, 2, 3])
    func clearReleasesElements(count: Int) {
        let list = CircleLinkedList<Payload>()
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

    @Test("销毁循环链表时应释放所有元素", arguments: [1, 2, 3])
    func deallocationReleasesElements(count: Int) {
        var list: CircleLinkedList<Payload>? = CircleLinkedList()
        let references = (0..<count).map { _ in
            let payload = Payload()
            list?.add(element: payload)
            return WeakPayload(payload)
        }

        #expect(references.allSatisfy { $0.value != nil })
        list = nil
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test("删除所有元素时应释放最后一个节点的自引用", arguments: [1, 2, 3])
    func removingAllElementsReleasesElements(count: Int) {
        let list = CircleLinkedList<Payload>()
        let references = (0..<count).map { _ in
            let payload = Payload()
            list.add(element: payload)
            return WeakPayload(payload)
        }

        #expect(references.allSatisfy { $0.value != nil })
        for _ in 0..<count {
            _ = list.remove(index: 0)
        }
        #expect(list.isEmpty())
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test("读取 index == size 时应由越界检查拒绝")
    func getAtSizeRejectsOutOfBoundsIndex() async {
        let result = await #expect(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) {
            let list = CircleLinkedList<Int>()
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
            let list = CircleLinkedList<Int>()
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

    @Test func testCircleLinkedList() async throws {
        
        let list = CircleLinkedList<Int>()
        list.add(element: 11) // [11]
        list.add(element: 22) // [11, 22]
        list.add(element: 33) // [11, 22, 33]
        list.add(element: 44) // [11, 22, 33, 44]
        list.add(index: 0, element: 55) // [55, 11, 22, 33, 44]
        list.add(index: 2, element: 66) // [55, 11, 66, 22, 33, 44]
        list.add(index: list.size(), element: 77) // [55, 11, 66, 22, 33, 44, 77]
        _ = list.remove(index: 0) // [11, 66, 22, 33, 44, 77]
        _ = list.remove(index: 2) // [11, 66, 33, 44, 77]
        _ = list.remove(index: list.size() - 1) // [11, 66, 33, 44]
        
        assert(list.size() == 4)
        assert(list.get(index: 0) == 11)
        assert(list.get(index: 1) == 66)
        assert(list.get(index: 2 ) == 33)
        assert(list.get(index: 3) == 44)
    }

}

//
//  CircleDoubleLinkedListTests.swift
//  AlgoTests
//
//  Created by hong on 3/3/25.
//

import Testing

struct CircleDoubleLinkedListTests {

    @Test func testCircleDoubleLinkedList() async throws {
        
        let list = CircleDoubleLinkedList<Int>()
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
        
        #expect(list.size() == 4)
        #expect(list.get(index: 0) == 11)
        #expect(list.get(index: 1) == 66)
        #expect(list.get(index: 2) == 33)
        #expect(list.get(index: 3) == 44)
    }

    @Test func testRemovingOnlyElement() async throws {
        
        let list = CircleDoubleLinkedList<Int>()
        list.add(element: 11) // [11]
        list.reset()
        #expect(list.remove(index: 0) == 11)
        
        #expect(list.size() == 0)
        #expect(list.current == nil)
        #expect(list.next() == nil)
        #expect(list.remove() == nil)
        #expect(list.size() == 0)
    }

    @Test("清空会重置游标，并允许重新添加和删除元素")
    func clearThenReusePreservesListState() {
        let list = CircleDoubleLinkedList<Int>()
        list.add(element: 10)
        list.reset()
        list.clear()

        #expect(list.isEmpty())
        #expect(list.current == nil)
        #expect(list.next() == nil)
        #expect(list.remove() == nil)

        list.add(element: 20)
        list.add(element: 30)
        #expect(list.size() == 2)
        #expect(list.get(index: 0) == 20)
        #expect(list.get(index: 1) == 30)
        #expect(list.contains(element: 20))
        #expect(list.indexOf(element: 30) == 1)

        list.reset()
        #expect(list.next() == 30)
        #expect(list.next() == 20)
        #expect(list.remove() == 20)
        #expect(list.remove() == 30)
        #expect(list.isEmpty())

        list.add(element: 40)
        #expect(list.get(index: 0) == 40)
        #expect(list.contains(element: 40))
    }

    @Test("混合索引删除和游标删除时，游标始终指向剩余节点")
    func indexedRemovalKeepsCursorValid() {
        let list = CircleDoubleLinkedList<Int>()
        for element in [10, 20, 30, 40] {
            list.add(element: element)
        }
        list.reset()

        #expect(list.remove(index: 1) == 20)
        #expect(list.current?.element == 10)
        let removedNode = list.current
        #expect(list.remove(index: 0) == 10)
        #expect(removedNode?.next == nil)
        #expect(removedNode?.prev == nil)
        #expect(list.current?.element == 30)

        #expect(list.next() == 40)
        #expect(list.remove(index: 1) == 40)
        #expect(list.current?.element == 30)
        #expect(list.remove() == 30)
        #expect(list.remove() == nil)
        #expect(list.next() == nil)
        #expect(list.size() == 0)
    }

    @Test("约瑟夫问题中每数到第三个节点时删除当前节点")
    func josephusEliminationOrder() {
        let list = CircleDoubleLinkedList<Int>()
        for element in 1...8 {
            list.add(element: element)
        }
        list.reset()

        var eliminated: [Int] = []
        for _ in 0..<8 {
            _ = list.next()
            _ = list.next()
            if let element = list.remove() {
                eliminated.append(element)
            }
        }

        #expect(eliminated == [3, 6, 1, 5, 2, 8, 4, 7])
        #expect(list.isEmpty())
        #expect(list.current == nil)
    }

    @Test("清空循环链表时应释放所有元素", arguments: [1, 2, 3])
    func clearReleasesElements(count: Int) {
        let list = CircleDoubleLinkedList<Payload>()
        let references = (0..<count).map { _ in
            let payload = Payload()
            list.add(element: payload)
            return WeakPayload(payload)
        }
        list.reset()

        #expect(references.allSatisfy { $0.value != nil })
        list.clear()
        #expect(list.isEmpty())
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test("销毁循环链表时应释放所有元素", arguments: [1, 2, 3])
    func deallocationReleasesElements(count: Int) {
        var list: CircleDoubleLinkedList<Payload>? = CircleDoubleLinkedList()
        let references = (0..<count).map { _ in
            let payload = Payload()
            list?.add(element: payload)
            return WeakPayload(payload)
        }
        list?.reset()

        #expect(references.allSatisfy { $0.value != nil })
        list = nil
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test("删除唯一节点时应断开自引用并释放元素", arguments: [false, true])
    func removingOnlyElementReleasesElement(usingCursor: Bool) {
        let list = CircleDoubleLinkedList<Payload>()
        let reference: WeakPayload
        do {
            let payload = Payload()
            reference = WeakPayload(payload)
            list.add(element: payload)
        }
        list.reset()

        if usingCursor {
            _ = list.remove()
        } else {
            _ = list.remove(index: 0)
        }

        #expect(list.isEmpty())
        #expect(list.current == nil)
        #expect(reference.value == nil)
    }

    @Test("读取 index == size 时应由越界检查拒绝")
    func getAtSizeRejectsOutOfBoundsIndex() async {
        let result = await #expect(
            processExitsWith: .failure,
            observing: [\.standardErrorContent]
        ) {
            let list = CircleDoubleLinkedList<Int>()
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
            let list = CircleDoubleLinkedList<Int>()
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
}

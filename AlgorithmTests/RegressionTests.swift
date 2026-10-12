//
//  RegressionTests.swift
//  AlgoTests
//
//  Created by hong on 10/12/26.
//

import Foundation
import Testing

/// 针对已修复bug的回归测试：用Swift标准库的Set/Dictionary作为参照
struct RegressionTests {

    /// 固定种子的伪随机数生成器，保证失败可复现
    struct SeededGenerator: RandomNumberGenerator {
        var state: UInt64
        mutating func next() -> UInt64 {
            state = state &* 6364136223846793005 &+ 1442695040888963407
            return state
        }
    }

    private func inorder<T>(_ node: BinaryTree<T>.Node<T>?, into result: inout [T]) {
        guard let node = node else { return }
        inorder(node.left, into: &result)
        result.append(node.element)
        inorder(node.right, into: &result)
    }

    /// 随机增删，对比Set，并检查中序有序、父指针正确、树高满足上界
    private func checkTree(_ tree: BST<Int>, maxHeight: (Int) -> Double) {
        var rng = SeededGenerator(state: 42)
        var expected = Set<Int>()

        for _ in 0..<3000 {
            let v = Int.random(in: 0..<300, using: &rng)
            if Bool.random(using: &rng) {
                tree.add(element: v)
                expected.insert(v)
            } else {
                tree.remove(element: v)
                expected.remove(v)
            }

            #expect(tree.size == expected.count)
            var elements: [Int] = []
            inorder(tree.root, into: &elements)
            #expect(elements == expected.sorted())
            #expect(Double(tree.height()) <= maxHeight(expected.count))
        }

        for v in 0..<300 {
            #expect(tree.contains(element: v) == expected.contains(v))
        }
    }

    @Test func bstRandomAddRemove() {
        checkTree(BST<Int>(), maxHeight: { Double($0) })
    }

    @Test func avlTreeRandomAddRemove() {
        checkTree(AVLTree<Int>(), maxHeight: { 1.45 * log2(Double($0) + 2) })
    }

    @Test func rbTreeRandomAddRemove() {
        checkTree(RBTree<Int>(), maxHeight: { 2 * log2(Double($0) + 1) })
    }

    @Test func binaryTreeRecursiveHeight() {
        let tree = BST<Int>()
        for v in [1, 2, 3, 4] { tree.add(element: v) } // 全部在右侧
        #expect(tree.height2() == 4)
        #expect(tree.height2() == tree.height())
    }

    @Test func treeMapRandomPutRemove() {
        var rng = SeededGenerator(state: 7)
        let map = TreeMap<Int, Int>()
        var expected: [Int: Int] = [:]

        for _ in 0..<3000 {
            let k = Int.random(in: 0..<300, using: &rng)
            if Bool.random(using: &rng) {
                let v = Int.random(in: 0..<1000, using: &rng)
                #expect(map.put(key: k, value: v) == expected.updateValue(v, forKey: k))
            } else {
                map.remove(key: k)
                expected.removeValue(forKey: k)
            }
            #expect(map.getSize() == expected.count)
        }

        for k in 0..<300 {
            #expect(map.get(key: k) == expected[k])
        }
    }

    @Test func binaryHeapSize() {
        let heap = BinaryHeap<Int>()
        #expect(heap.isEmpty())
        for v in [68, 72, 43, 50, 38] { heap.add(element: v) }
        #expect(heap.getSize() == 5)
        #expect(!heap.isEmpty())

        var popped: [Int] = []
        while !heap.isEmpty() { popped.append(heap.remove()) }
        #expect(popped == [72, 68, 50, 43, 38])

        let heapified = BinaryHeap(elements: [3, 1, 2])
        #expect(heapified.getSize() == 3)
        #expect(heapified.replace(element: 0) == 3)
        #expect(heapified.getSize() == 3)
    }

    @Test func priorityQueueEmpty() {
        let queue = PriorityQueue<Int>()
        #expect(queue.isEmpty())
        #expect(queue.front() == nil)
        #expect(queue.deQueue() == nil)
        queue.enQueue(element: 1)
        queue.enQueue(element: 5)
        #expect(queue.getSize() == 2)
        #expect(queue.deQueue() == 5)
    }

    @Test func hashValueLongAndNonASCIIString() {
        // 原实现在长字符串上整数溢出、在非ASCII字符上强制解包崩溃
        _ = Hash.hashValue(string: String(repeating: "z", count: 100))
        _ = Hash.hashValue(string: "你好")
        #expect(Hash.hashValue(string: "jack") == 3254239)
    }

    @Test func quickSortSortedInput() {
        // 有序输入会让固定首元素轴点退化成O(n)的递归深度
        var array = Array(0..<50_000)
        QuickSort<Int>().sort(array: &array)
        #expect(array == Array(0..<50_000))

        var rng = SeededGenerator(state: 1)
        var random = (0..<1000).map { _ in Int.random(in: 0..<50, using: &rng) }
        let want = random.sorted()
        QuickSort<Int>().sort(array: &random)
        #expect(random == want)
    }

    @Test func sortFunctionsOnEmptyArray() {
        var empty: [Int] = []
        bubbleSort1(array: &empty)
        selelctionSort(array: &empty)
        #expect(empty.isEmpty)
    }

    @Test func mergeSortedArrayFirstElement() {
        var nums1 = [2, 0]
        Solution().merge(&nums1, 1, [1], 1)
        #expect(nums1 == [1, 2])

        var nums2 = [4, 5, 6, 0, 0, 0]
        Solution().merge(&nums2, 3, [1, 2, 3], 3)
        #expect(nums2 == [1, 2, 3, 4, 5, 6])
    }

    @Test func reverseListRecursive() {
        typealias Node = Solution206.ListNode
        let head = Node(1, Node(2, Node(3)))
        var node = Solution206().reverseList1(head)
        var values: [Int] = []
        while let n = node { values.append(n.val); node = n.next }
        #expect(values == [3, 2, 1])
        #expect(Solution206().reverseList1(Node(7))?.val == 7)
    }

    @Test func validParenthesesUnmatchedRight() {
        #expect(Solution20().isValid("]") == false)
        #expect(Solution20().isValid("())") == false)
        #expect(Solution20().isValid("([)]") == false)
        #expect(Solution20().isValid("{[]}") == true)
    }
}

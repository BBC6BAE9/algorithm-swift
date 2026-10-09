import Testing

struct ArrayListCapacityTests {
    @Test("反复添加并删除唯一元素后，数组仍能继续使用")
    func testRepeatedAddRemoveOnEmptyList() {
        let arrList = ArrayList<Int>()
        for value in 0..<20 {
            arrList.add(element: value)
            #expect(arrList.remove(index: 0) == value)
            #expect(arrList.isEmpty())
            #expect(arrList.size() == 0)
        }

        arrList.add(element: 42)
        #expect(arrList.size() == 1)
        #expect(arrList.get(index: 0) == 42)
    }

    @Test("扩容、缩容再插入后，元素和顺序仍然正确", arguments: [10, 15, 40])
    func testGrowShrinkAndRegrow(initialCapacity: Int) {
        let arrList = ArrayList<Int>(capacity: initialCapacity)
        var expected = Array(0..<40)
        for value in expected {
            arrList.add(element: value)
        }

        // 从首尾交替删除，跨过多次缩容边界。
        for step in 0..<35 {
            let index = step.isMultiple(of: 2) ? 0 : expected.count - 1
            let removed = expected.remove(at: index)
            #expect(arrList.remove(index: index) == removed)
            #expect(arrList.size() == expected.count)
        }
        #expect((0..<expected.count).map { arrList.get(index: $0) } == expected.map { Optional($0) })

        // 缩容后在中间插入，同时验证扩容和元素右移。
        for value in 100..<140 {
            let index = expected.count / 2
            expected.insert(value, at: index)
            arrList.add(index: index, element: value)
        }
        #expect(arrList.size() == expected.count)
        #expect((0..<expected.count).map { arrList.get(index: $0) } == expected.map { Optional($0) })

        arrList.clear()
        #expect(arrList.isEmpty())
        arrList.add(element: 99)
        #expect(arrList.size() == 1)
        #expect(arrList.get(index: 0) == 99)
    }
}

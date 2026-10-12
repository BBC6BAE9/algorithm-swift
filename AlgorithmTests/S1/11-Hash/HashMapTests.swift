import Testing

struct HashMapTests {

    private struct CollisionKey: Hashable {
        let id: Int

        func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }
    }

    private final class TrackedValue: Equatable {
        let id: Int

        init(_ id: Int) {
            self.id = id
        }

        static func == (lhs: TrackedValue, rhs: TrackedValue) -> Bool {
            lhs === rhs
        }
    }

    private final class WeakValue {
        weak var value: TrackedValue?
    }

    private struct Generator {
        private var state: UInt64 = 0x1234_5678_9ABC_DEF0

        mutating func next() -> UInt64 {
            state = state &* 6_364_136_223_846_793_005 &+ 1
            return state >> 32
        }
    }

    @Test func initializationAndMissingKeys() {
        let map = HashMap<String, Int>()

        #expect(map.getSize() == 0)
        #expect(map.isEmpty())
        #expect(map.get(key: "missing") == nil)
        #expect(!map.containsKey(key: "missing"))
        #expect(!map.containsValue(value: 1))
        #expect(!map.containsValue(value: nil))

        #expect(map.put(key: nil, value: 1) == nil)
        map.remove(key: "missing")
        map.clear()
        #expect(map.getSize() == 0)
        #expect(map.isEmpty())
    }

    @Test func replacingAValueReturnsThePreviousValue() {
        let map = HashMap<String, Int>()

        #expect(map.put(key: "year", value: 2000) == nil)
        #expect(map.put(key: "month", value: 10) == nil)
        #expect(map.put(key: "year", value: 2026) == 2000)
        #expect(map.put(key: "year", value: 2026) == 2026)
        #expect(map.getSize() == 2)
        #expect(!map.isEmpty())
        #expect(map.get(key: "year") == 2026)
        #expect(map.get(key: "month") == 10)
        #expect(map.containsValue(value: 2026))
        #expect(!map.containsValue(value: 2000))
    }

    @Test func equalHashesKeepDistinctKeys() {
        let map = HashMap<CollisionKey, Int>()

        for id in 0..<96 {
            #expect(map.put(key: CollisionKey(id: id), value: id * 3) == nil)
        }

        #expect(map.getSize() == 96)
        #expect(map.put(key: CollisionKey(id: 47), value: -1) == 141)
        #expect(map.getSize() == 96)

        for id in 0..<96 {
            #expect(map.containsKey(key: CollisionKey(id: id)))
            #expect(map.get(key: CollisionKey(id: id)) == (id == 47 ? -1 : id * 3))
        }
        #expect(!map.containsKey(key: CollisionKey(id: 96)))
    }

    @Test func removingCollidingKeysPreservesEveryRemainingEntry() {
        let map = HashMap<CollisionKey, Int>()
        let insertionOrder = [7, 3, 11, 1, 5, 9, 13, 0, 2, 4, 6, 8, 10, 12, 14]
        let removalOrder = [7, 0, 14, 3, 11, 1, 13, 5, 9, 2, 4, 6, 8, 10, 12]
        var remaining: [Int: Int] = [:]

        for id in insertionOrder {
            _ = map.put(key: CollisionKey(id: id), value: id + 100)
            remaining[id] = id + 100
        }
        map.remove(key: CollisionKey(id: -1))
        #expect(map.getSize() == remaining.count)

        for removedID in removalOrder {
            map.remove(key: CollisionKey(id: removedID))
            remaining.removeValue(forKey: removedID)
            // 重复删除同一个键也不应影响其他元素或数量。
            map.remove(key: CollisionKey(id: removedID))

            #expect(map.getSize() == remaining.count)
            for id in insertionOrder {
                #expect(map.get(key: CollisionKey(id: id)) == remaining[id])
                #expect(map.containsKey(key: CollisionKey(id: id)) == (remaining[id] != nil))
            }
        }
        #expect(map.isEmpty())
    }

    @Test func growthPreservesHundredsOfEntriesAndExtremeKeys() {
        let map = HashMap<Int, Int>()
        var expected: [Int: Int] = [:]

        for key in -320..<320 {
            _ = map.put(key: key, value: key * key)
            expected[key] = key * key
        }
        for key in [Int.min, Int.max] {
            _ = map.put(key: key, value: 999)
            expected[key] = 999
        }
        #expect(map.getSize() == 642)

        for (key, value) in expected {
            #expect(map.get(key: key) == value)
        }

        for key in stride(from: -320, to: 320, by: 3) {
            map.remove(key: key)
            expected.removeValue(forKey: key)
        }
        #expect(map.getSize() == expected.count)
        for key in -320..<320 {
            #expect(map.get(key: key) == expected[key])
        }
        #expect(map.get(key: Int.min) == 999)
        #expect(map.get(key: Int.max) == 999)
    }

    @Test func clearAllowsTheMapToBeReused() {
        let map = HashMap<CollisionKey, Int>()

        for id in 0..<80 {
            _ = map.put(key: CollisionKey(id: id), value: id)
        }
        map.clear()
        map.clear()
        #expect(map.isEmpty())
        #expect(map.getSize() == 0)
        for id in 0..<80 {
            #expect(!map.containsKey(key: CollisionKey(id: id)))
        }
        #expect(!map.containsValue(value: 79))

        #expect(map.put(key: CollisionKey(id: 79), value: 800) == nil)
        #expect(map.put(key: CollisionKey(id: 100), value: 900) == nil)
        #expect(map.getSize() == 2)
        #expect(map.get(key: CollisionKey(id: 79)) == 800)
        #expect(map.get(key: CollisionKey(id: 100)) == 900)
    }

    @Test func optionalValuesDistinguishStoredNilFromAMissingKey() {
        let map = HashMap<String, Int?>()

        #expect(map.put(key: "empty", value: nil) == nil)
        #expect(map.put(key: "number", value: 42) == nil)
        #expect(map.containsKey(key: "empty"))
        #expect(map.get(key: "empty") == .some(nil))
        #expect(map.get(key: "missing") == nil)
        // 外层 Optional 表示查询参数，内层 Optional 是实际存储的值。
        #expect(map.containsValue(value: .some(nil)))
        #expect(map.containsValue(value: .some(.some(42))))
        #expect(!map.containsValue(value: nil))

        #expect(map.put(key: "empty", value: 7) == .some(nil))
        #expect(map.getSize() == 2)
        #expect(!map.containsValue(value: .some(nil)))
        #expect(map.get(key: "empty") == .some(.some(7)))
        map.remove(key: "empty")
        #expect(!map.containsKey(key: "empty"))
        #expect(map.containsKey(key: "number"))
    }

    @Test func removeAndReplacementReleaseTheirPreviousValues() {
        let map = HashMap<CollisionKey, TrackedValue>()
        weak var removedValue: TrackedValue?
        weak var replacedValue: TrackedValue?

        do {
            let first = TrackedValue(1)
            let second = TrackedValue(2)
            removedValue = first
            replacedValue = second
            _ = map.put(key: CollisionKey(id: 1), value: first)
            _ = map.put(key: CollisionKey(id: 2), value: second)
            _ = map.put(key: CollisionKey(id: 3), value: TrackedValue(3))
        }
        #expect(removedValue != nil)
        #expect(replacedValue != nil)

        map.remove(key: CollisionKey(id: 1))
        #expect(removedValue == nil)
        _ = map.put(key: CollisionKey(id: 2), value: TrackedValue(20))
        #expect(replacedValue == nil)
        #expect(map.getSize() == 2)
        #expect(map.get(key: CollisionKey(id: 2))?.id == 20)
        #expect(map.get(key: CollisionKey(id: 3))?.id == 3)
    }

    @Test func clearAndDeinitializationReleaseAllValues() {
        var map: HashMap<CollisionKey, TrackedValue>? = HashMap()
        let references = (0..<24).map { _ in WeakValue() }

        for id in references.indices {
            let value = TrackedValue(id)
            references[id].value = value
            _ = map?.put(key: CollisionKey(id: id), value: value)
        }
        #expect(references.allSatisfy { $0.value != nil })
        map?.clear()
        #expect(references.allSatisfy { $0.value == nil })

        for id in references.indices {
            let value = TrackedValue(id + 100)
            references[id].value = value
            _ = map?.put(key: CollisionKey(id: id), value: value)
        }
        #expect(references.allSatisfy { $0.value != nil })
        map = nil
        #expect(references.allSatisfy { $0.value == nil })
    }

    @Test func deterministicOperationsMatchSwiftDictionary() {
        let map = HashMap<CollisionKey, Int>()
        var expected: [CollisionKey: Int] = [:]
        var generator = Generator()

        for step in 0..<1_600 {
            let key = CollisionKey(id: Int(generator.next() % 64))
            let operation = generator.next() % 10

            switch operation {
            case 0...4:
                let value = Int(generator.next() % 1_000) - 500
                let previous = expected.updateValue(value, forKey: key)
                #expect(map.put(key: key, value: value) == previous)
            case 5...7:
                map.remove(key: key)
                expected.removeValue(forKey: key)
            case 8:
                #expect(map.get(key: key) == expected[key])
            default:
                if step % 97 == 0 {
                    map.clear()
                    expected.removeAll()
                } else {
                    let value = Int(generator.next() % 1_000) - 500
                    #expect(map.containsValue(value: value) == expected.values.contains(value))
                }
            }

            #expect(map.getSize() == expected.count)
            #expect(map.isEmpty() == expected.isEmpty)
            for id in 0..<64 {
                let candidate = CollisionKey(id: id)
                #expect(map.get(key: candidate) == expected[candidate])
                #expect(map.containsKey(key: candidate) == (expected[candidate] != nil))
            }
        }
    }
}

//
//  MapTests.swift
//  AlgoTests
//
//  Created by hong on 4/21/25.
//

import Testing

struct MapTests {

    @Test func testMap() async throws {
        let map = TreeMap<String, Int>()
        _ = map.put(key: "year", value: 2000)
        _ = map.put(key: "month", value: 1)
        _ = map.put(key: "day", value: 23)
        _ = map.put(key: "year", value: 2001)
        
        
        let ret = map.get(key: "year")
        let want = 2001
        assert(ret == want)
    }

}

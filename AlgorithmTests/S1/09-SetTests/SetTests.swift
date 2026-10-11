//
//  ListSetTests.swift
//  AlgoTests
//
//  Created by hong on 4/21/25.
//

import Testing

struct ListSetTests {

    @Test func testListSet() async throws {
        let listSet = ListSet<Int>()
        listSet.add(element: 10)
        listSet.add(element: 11)
        listSet.add(element: 11)
        listSet.add(element: 10)
        
        for element in listSet {
            print(element)
        }
        
        let ret = listSet.size()
        let want = 2
        assert(ret == want)
    }
    
    @Test func testTreeSet() async throws {
        let listSet = TreeSet<Int>()
        listSet.add(element: 10)
        listSet.add(element: 11)
        listSet.add(element: 11)
        listSet.add(element: 10)
        
        let ret = listSet.size()
        let want = 2
        assert(ret == want)
    }

    @Test func testMapSet() async throws {
        let listSet = MapSet<Int>()
        listSet.add(element: 10)
        listSet.add(element: 11)
        listSet.add(element: 11)
        listSet.add(element: 10)
        
        let ret = listSet.size()
        let want = 2
        assert(ret == want)
    }
}
 

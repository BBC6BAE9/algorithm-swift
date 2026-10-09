//
//  Solution.swift
//  Algo
//
//  Created by hong on 3/3/25.
// 237 https://leetcode.cn/problems/delete-node-in-a-linked-list/?utm_source=LCUS&utm_medium=ip_redirect&utm_campaign=transfer2china

import Foundation

// Definition for singly-linked list.

class Solution237 {
    
    class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }

    func deleteNode(_ node: Solution237.ListNode?) {
        node?.val =  node?.next?.val ?? 0
        node?.next =  node?.next?.next
    }
    
}

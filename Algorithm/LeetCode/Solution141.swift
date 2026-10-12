//
//  Solution141.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

// 141 https://leetcode.cn/problems/linked-list-cycle/
/*
 给你一个链表的头节点 head ，判断链表中是否有环。

 如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。注意：pos 不作为参数进行传递 。仅仅是为了标识链表的实际情况。
 */

class Solution141 {
    
    // Definition for singly-linked list.
    class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }

    /// 判断链表是否有环
    /// 解题思路：快慢指针，慢指针一次走一步，快指针一次走两步，如果有环，走到一定程度会相遇，如果快指针先到nil可说明没有环
    func hasCycle(_ head: ListNode?) -> Bool {
        guard let head = head,
              head.next != nil else { return false }
        
        var slow: ListNode? = head
        var fast: ListNode? = head.next
        
        while fast != nil && fast?.next != nil {
            if slow === fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
}

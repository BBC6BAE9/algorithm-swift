//
//  Solution206.swift
//  Algo
//
//  Created by hong on 3/3/25.
//

import Foundation

// 206. 反转链表    https://leetcode.cn/problems/reverse-linked-list/
class Solution206 {
    // Definition for singly-linked list.
    class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }
    
    // 递归的解决方法
    func reverseList1(_ head: Solution206.ListNode?) -> Solution206.ListNode? {
        if head == nil,
           head?.next == nil // 头节点没有next，说明只有一个节点，反转之后还是自己
        {
            return head
        }
        
        let newHead = reverseList1(head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
    
    func reverseList2(_ head: Solution206.ListNode?) -> Solution206.ListNode? {
        var head = head
        if head == nil,
           head?.next == nil // 头节点没有next，说明只有一个节点，反转之后还是自己
        {
            return head
        }
        
        var newHead: ListNode? = nil
        while head != nil {
            let tmp = head?.next
            head?.next = newHead
            newHead = head
            head = tmp
        }
        
        return newHead
    }
    
}
